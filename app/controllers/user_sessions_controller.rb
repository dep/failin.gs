class UserSessionsController < ApplicationController
  respond_to :html

  before_filter :require_no_user, only: %w(new create)

  def new
    @user = User.new
    @user_session = UserSession.new
    @user.login = @user_session.login = twitter[:screen_name] if twitter
    respond_with @user_session
  end

  def create
    @user = User.new
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      session[:invitation_email] = nil

      if twitter
        redirect_to oauth_complete_path
      else
        redirect_back_or_default profile_path(@user_session.user),
          notice: "Login successful!"
      end
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
