# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def gravatar_for(user, *args)
    user.email ||= "" and super.html_safe
  end

  def image_url(*args)
    return super if ActionController::Base.asset_host
    request.protocol + request.host_with_port + image_path(*args)
  end

  def simple_format(text, html_options={})
    start_tag = tag('p', html_options, true)
    text = h(text)
    text.gsub!(/^\s*/, start_tag)
    text.gsub!(/\s*$/, '</p>')
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text
  end
end
