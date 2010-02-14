FailinGs::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.server_settings = {
  #   address:        "smtp.gmail.com",
  #   port:           587,
  #   authentication: :plain
  #   user_name:      "app@failin.gs",
  #   password:       "dp@VP#09"
  # }

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.default_url_options = { host: "failin.gs" }

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  require "lib/exception_notifier"
  config.middleware.use ExceptionNotifier
end
