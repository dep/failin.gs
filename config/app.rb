class App < Configurable
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails::Application.instance.class.parent.name

  config.beta = true

  # Uncomment this line to avoid expensive SQL queries on public profiles.
  # config.optimized = true

  config.launched_at = Time.now.utc

  config.javascript_expansions = {
    prototype: %w(prototype effects dragdrop controls),
    facebook: "http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US"
  }

  # Facebook API.
  config.facebook = {
    app_name: "failin.gs",
    api_key: "434cc2cf73449662eadb3fb817cc50ac",
    application_secret: "5ec28c1f4d3377c4bd640e901c7ecb1b"
  }

  # Twitter API.
  config.twitter = {
    key: "fu7W2TpOgprzROGoumRF4Q",
    secret: "ALhgi9iVPxjbvbygcIX1WcbnnR2NtsRZ1CF2xxxmWDI",
    site: "http://twitter.com"
  }
end
