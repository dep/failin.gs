class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :logged_in?

  private

  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined? @current_user
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    unless logged_in?
      redirect_to new_user_session_path
      return false
    end
  end

  def require_no_user
    if logged_in?
      redirect_to profile_url(current_user)
      return false
    end
  end
end
