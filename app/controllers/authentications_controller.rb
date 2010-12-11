class AuthenticationsController < ApplicationController
  # TODO: Cleanup.
  def callback
    auth = request.env['omniauth.auth']

    if logged_in?
      session[:invitation_email] = nil

      case auth["provider"]
      when 'facebook'
        current_user.facebook_id         = auth["uid"]
        current_user.facebook_token      = auth["credentials"]["token"]
      when 'twitter'
        current_user.twitter_screen_name = auth["user_info"]["nickname"]
        current_user.twitter_id          = auth["uid"]
        current_user.oauth_token         = auth["credentials"]["token"]
        current_user.oauth_secret        = auth["credentials"]["secret"]
      end

      current_user.preferences["avatar_service"] ||= auth["provider"]

      if current_user.changed? && current_user.save
        flash[:notice] = "Connected with #{auth["provider"].capitalize}!"
      end

      redirect_to edit_account_path
      return
    else
      user = case auth["provider"]
      when 'facebook'
        User.find_by_facebook_token auth["credentials"]["token"]
      when 'twitter'
        User.find_by_oauth_token auth["credentials"]["token"]
      end

      if user
        session[:invitation_email] = nil

        UserSession.create user
        redirect_to profile_path(user), notice: "Login successful!"
        return
      end
    end

    session[:auth] = auth.slice 'provider', 'uid', 'credentials', 'user_info'
    session[:auth][:email] = auth['extra']['user_hash']['email']
    redirect_to login_path
  end

  # params[:message] == 'invalid_credentials'
  def failure
    render text: request.env, content_type: 'text/plain'
  end

  def destroy
    case params[:provider]
    when 'facebook'
      current_user.facebook_id         = nil
      current_user.facebook_token      = nil
    when 'twitter'
      current_user.twitter_screen_name = nil
      current_user.twitter_id          = nil
      current_user.oauth_token         = nil
      current_user.oauth_secret        = nil
    end

    current_user.save validate: false if current_user.changed?
    redirect_to edit_account_path,
      notice: "#{params[:provider].capitalize} unlinked."
  end
end
