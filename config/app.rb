class App < Configurable
  # Settings in config/app/* take precedence over those specified here.
  config.name = 'FailinGs'

  config.beta = false

  # Make true to avoid expensive SQL queries on public profiles.
  config.optimized = false

  config.launched_at = Time.now.utc

  config.javascript_expansions ||= {
    prototype: %w(prototype effects dragdrop controls)
  }

  config.twitter = {
    key:    "fu7W2TpOgprzROGoumRF4Q",
    secret: "ALhgi9iVPxjbvbygcIX1WcbnnR2NtsRZ1CF2xxxmWDI",
  }

  config.facebook = {
    key:    "434cc2cf73449662eadb3fb817cc50ac",
    secret: "5ec28c1f4d3377c4bd640e901c7ecb1b"
  }
end
