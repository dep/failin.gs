# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for :title, page_title
  end

  def avatar_for(user, *args)
    if user.avatar_service.facebook?
      facebook_image_for user, *args
    elsif user.avatar_service.twitter?
      tweetimage_for user, *args
    else
      gravatar_for user, *args
    end
  end

  def facebook_image_for(user, *args)
    options = args.extract_options!
    image_url = "http://graph.facebook.com/#{user.facebook_id}/picture&type="
    image_url << case options[:size]
      when 0..50 then 'square'
      else 'large'
    end

    image_tag image_url, width: options[:size]
  end

  def tweetimage_for(user, *args)
    options = args.extract_options!
    tweetimage_url = "http://tweetimag.es/i/#{user.twitter_screen_name}_"
    tweetimage_url << case options[:size]
      when 0..24  then "m"
      when 25..48 then "n"
      when 48..73 then "b"
      else             "o"
    end

    image_tag tweetimage_url, width: options[:size]
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

  def twitter_login
    button_to "Log in or sign up with Twitter", twitter_login_path, class: "twitter_auth"
  end
end
