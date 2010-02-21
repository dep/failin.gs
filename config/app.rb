require "lib/configurable"

class App < Configurable
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails::Application.instance.class.parent.name

  config.beta = true

  # Uncomment this line to avoid expensive SQL queries on public profiles.
  # config.optimized = true

  config.launched_at = Time.now.utc

  config.javascript_expansions ||= {
    prototype: %w(prototype effects dragdrop controls)
  }

  # Twitter API.
  config.twitter = {
    key: "fu7W2TpOgprzROGoumRF4Q",
    secret: "ALhgi9iVPxjbvbygcIX1WcbnnR2NtsRZ1CF2xxxmWDI",
    site: "http://twitter.com"
  }
end
