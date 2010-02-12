App.configure do
  # Settings specified here will take precedence over those in config/app.rb

  # config.key = "value"

  config.javascript_expansions = {
    prototype: %w(
      http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js
      http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.3/scriptaculous.js
    )
  }
end
