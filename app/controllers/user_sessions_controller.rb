class UserSessionsController < ApplicationController
  respond_to :html

  before_filter :require_no_user, only: %w(new create)

  def new
    @user = User.new
    @user_session = UserSession.new

    if auth
      if auth["provider"] == "facebook"
        @user.answer = auth["user_info"]["last_name"]
        @user.email = @user_session.login = auth[:email]
      end

      if auth["provider"] == "twitter"
        @user.login = @user_session.login = auth["user_info"]["nickname"]
      end
    end

    respond_with @user_session
  end

  def create
    @user = User.new
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      session[:invitation_email] = nil

      if auth
        @user.apply_auth auth
        @user.save
      end

      redirect_back_or_default profile_path(@user_session.user),
        notice: "Login successful!"
    else
      render "new"
    end
  end

  def destroy
    if current_user_session
      current_user.reset_persistence_token!
      current_user_session.destroy
    end

    session.delete :oauth
    redirect_to root_path
  end
end
