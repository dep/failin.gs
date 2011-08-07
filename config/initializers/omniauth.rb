Rails.configuration.middleware.use OmniAuth::Builder do
  options = { client_options: { ssl: { ca_path: "/etc/ssl/certs" } } }
  provider :facebook, App.facebook[:key], App.facebook[:secret], options
  provider :twitter,  App.twitter[:key],  App.twitter[:secret],  options
end
