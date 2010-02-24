module FacebookHelper


  def facebook_login_button(text = "Connect with Facebook", options = {})
    configuration = {
      v: "2", size: "medium", onlogin: "window.location.reload(true)"
    }.merge(options)

    content_tag "fb:login-button", text, configuration
  end

  def facebook_profile_pic(options = {})
    configuration = {
      uid: "loggedinuser", size: "square", "facebook-logo" => true
    }.merge(options)

    content_tag "fb:profile-pic", "", configuration
  end

  def facebook_name(options = {})
    configuration = {
      uid: "loggedinuser", useyou: false, linked: true
    }.merge(options)

    content_tag "fb:name", "", configuration
  end
end
