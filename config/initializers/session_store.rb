# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_failin.gs_session',
  :secret      => 'ea37a535b8e43810f9c96dc6d69a93302ec08c5879220d31959bc388f052cd3fc3564460b41edf9aa2480809ae22f18be8ca8a605034296b9ef234f461272eb1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
