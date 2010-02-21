FailinGs::Application.routes.draw do |map|
  resource :user_session
  get "login", to: "user_sessions#new", as: :login
  match "logout", to: "user_sessions#destroy", method: :delete, as: :logout

  oauth_complete_path = App.twitter[:redirect] || "/oauth_complete"
  get oauth_complete_path, to: "user_sessions#oauth", as: :oauth_complete
  delete "/oauth_delete", to: "users#unlink_oauth", as: :oauth_delete

  resource :account, controller: "users", only: %w(create edit update destroy)
  get "account" => redirect("/account/edit")

  resources :preferences

  resource :password, only: %w(new create edit update destroy),
    as: :password_reset

  resources :failings, as: "profile/:login/failings", only: %w(create show) do
    member do
      put :knew
      put :no_idea
      put :disagree
    end

    resources :comments, only: %w(create) do
      resource :abuse, only: %w(create)
    end
    resource :vote, only: %w(create)
    resource :abuse, only: %w(create)
  end

  resource :invitation, only: %w(new create)
  get "invitation/search", to: "invitations#search", as: :search

  resource :share, only: %w(new create)
  resource :email, only: %w(create)

  get "profile/:login(.:format)", to: "failings#index", as: :profile
  get "profile/:login/failings" => redirect("/profile/%{login}")

  get "pages/:action", to: "pages", action: /[a-z-]+/, as: :page

  # get "javascripts/:action.:format" => "javascripts"
  get "stylesheets/:action.:format" => "stylesheets"

  root to: "pages#root"

  get ":login" => redirect("/profile/%{login}")
end
