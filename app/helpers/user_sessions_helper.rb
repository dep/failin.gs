module UserSessionsHelper
  def twitter_login_path
    App.twitter[:login] || "/oauth_login"
  end
end
