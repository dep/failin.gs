require "uuid"

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_identity
  before_filter :load_from_email, unless: :logged_in?

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

  def load_from_email
    if params[:via] == "email"
      store_location
      redirect_to login_path
    end
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
      redirect_to login_path
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

  def auth
    session[:auth]
  end
  helper_method :auth

  def knows? user
    current_user == user || known.include?(user.id)
  end
  helper_method :knows?

  def knows! user
    return if knows? user
    session[:known] = (known << user.id).uniq
    @just_knew = user
  end

  def known
    session[:known] ||= begin
      known = []

      if logged_in?
        begin
          known += current_user.twitter_followers.map { |f| f.id }
          known += current_user.facebook_friends.map { |f| f.id }
        rescue => e
          logger.info e.to_s
        end
      end

      known
    end
  end
end
