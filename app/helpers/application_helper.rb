# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for :title, page_title
  end

  def avatar_for(user, *args)
    case user.preferences["avatar_service"]
    when "twitter"
      tweetimage_for user, *args
    else
      gravatar_for user, *args
    end
  end

  def tweetimage_for(user, *args)
    options = args.extract_options!

    @tweetimages ||= {}
    @tweetimages[user.twitter_screen_name] ||= begin
      tweetimage_url = "http://tweetimag.es/i/#{user.twitter_screen_name}_o"
      uri = URI.parse tweetimage_url
      request = Net::HTTP.new uri.host

      unless request.request_head(uri.path).is_a?(Net::HTTPOK)
        tweetimage_url = options[:default]
      end

      tweetimage_url
    end

    size = options[:size]
    image_tag @tweetimages[user.twitter_screen_name], width: size, height: size
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

  def twitter_link(user)
    "http://twitter.com/home?status=Got+a+profile+at+@failings,+the+site+that+lets+friends+give+me+completely+anonymous+feedback!+#{user}"
  end

  def facebook_link(user)
    "http://www.facebook.com/sharer.php?u=#{user}&src=sp"
  end
end
