ActionController::Routing::Routes.draw do |map|
  resource :user_session
  resource :user
  # resource :account, :controller => "users"
  # resources :users

  match "pages/:permalink", :to => "pages#show", :permalink => /[a-z-]+/

  root :to => "user_sessions#new"
end
