# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for :title, page_title
  end

  def gravatar_for(user, *args)
    user.email ||= "" and super.html_safe
  end

  def image_url(*args)
    return super if ActionController::Base.asset_host
    request.protocol + request.host_with_port + image_path(*args)
  rescue NoMethodError
    if host = ActionMailer::Base.default_url_options[:host]
      return "http://#{host}/#{image_path(*args)}"
    end

    raise
  end
end
