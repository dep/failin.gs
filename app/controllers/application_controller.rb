require "uuid"

class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :load_identity

  private

  # == Loaders

  def load_profile_user
    @user = User.find_by_login! params[:login]
  end

  def load_failing
    load_profile_user unless defined? @user
    @failing = @user.failings.find(params[:failing_id] || params[:id])
  end

  def load_identity
    @identity = cookies.signed[:identity] ||
      cookies.permanent.signed[:identity] = UUID.new.generate
  end

  # == Authentication

  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end
  helper_method :current_user_session

  def current_user
    return @current_user if defined? @current_user
    @current_user = if current_user_session
      if user = current_user_session.user
        user.active? ? user : current_user_session.destroy
      end
    end
  end
  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

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

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end
end
