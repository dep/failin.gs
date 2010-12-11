Rails.configuration.middleware.use OmniAuth::Builder do
  provider :facebook, App.facebook[:key], App.facebook[:secret]
  provider :twitter,  App.twitter[:key],  App.twitter[:secret]
end
