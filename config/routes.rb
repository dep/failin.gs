FailinGs::Application.routes.draw do |map|
  resource :user_session
  match "logout", to: "user_sessions#destroy", method: :delete

  resource :account, controller: "users"

  resources :failings, as: "profile/:login/failings", only: %w(create) do
    member do
      put :knew
      put :no_idea
      put :disagree
    end

    resources :comments
  end

  match "pages/:action", to: "pages", action: /[a-z-]+/
  match "profile/:login", to: "failings#index", as: :profile

  # resource :emails
  # root to: "emails#new"

  root to: "pages#root"
end
