class UserSessionsController < ApplicationController
  respond_to :html

  before_filter :require_no_user, only: %w(new create)

  def new
    @user = User.new
    @user.login = twitter[:screen_name] if twitter
    respond_with(@user_session = UserSession.new)
  end

  def create
    @user = User.new
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_back_or_default profile_path(@user_session.user),
        notice: "Login successful!"
    else
      render "new"
    end
  end

  def oauth
    if twitter
      if logged_in?
        current_user.twitter_screen_name = twitter[:screen_name]
        current_user.twitter_id          = twitter[:id]
        current_user.oauth_token         = twitter[:oauth_token]
        current_user.oauth_secret        = twitter[:oauth_token_secret]

        current_user.save if current_user.changed?

        redirect_to edit_account_path,
          notice: "Connected with Twitter!"
      elsif user = User.find_by_oauth_token(twitter[:oauth_token])
        UserSession.create user
        redirect_to profile_path(user), notice: "Login successful!"
      else
        redirect_to login_path, notice: "Complete your registration."
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user_session
      current_user.reset_persistence_token!
      current_user_session.destroy
    end

    session["rack.oauth"] = nil
    redirect_to root_path
  end
end
