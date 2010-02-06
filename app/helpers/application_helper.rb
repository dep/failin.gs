# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def gravatar_for(user, *args)
    user.email ||= "" and super.html_safe
  end

  def image_url(*args)
    return super if ActionController::Base.asset_host
    request.protocol + request.host_with_port + image_path(*args)
  end
end
