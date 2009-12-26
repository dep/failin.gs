ActionController::Routing::Routes.draw do |map|
  resource :user_session
  resource :user
  # resource :account, :controller => "users"
  # resources :users

  match "pages/:action", :to => "pages", :action => /[a-z-]+/

  resource :emails
  root :to => "emails#new"

  # root :to => "pages#root"
end
