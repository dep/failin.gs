FailinGs::Application.routes.draw do |map|
  resource :user_session
  match "logout", to: "user_sessions#destroy", method: :delete, as: :logout

  resource :account, controller: "users", only: %w(create edit update destroy)
  resource :password, only: %w(new create edit update destroy), as: :password_reset

  resources :failings, as: "profile/:login/failings", only: %w(create show) do
    member do
      put :knew
      put :no_idea
      put :disagree
    end

    resource :comment, only: %w(create)
    resource :vote,    only: %w(create)
    resource :abuse,   only: %w(create)
  end

  resource :invitation, only: %w(new create)
  resource :share,      only: %w(new create)

  get "profile/:login(.:format)", to: "failings#index", as: :profile
  get "profile/:login/failings" => redirect("/profile/%{login}")

  get "pages/:action",  to: "pages", action: /[a-z-]+/, as: :page

  # root to: "emails#new"
  resource :email, only: %w(create)

  # get "javascripts/:action.:format" => "javascripts"
  get "stylesheets/:action.:format" => "stylesheets"

  root to: "pages#root"
end
