FailinGs::Application.routes.draw do |map|
  resource :user_session
  match "logout", to: "user_sessions#destroy", method: :delete, as: :logout

  resource :account, controller: "users", only: %w(create edit update destroy)

  resources :failings, as: "profile/:login/failings", only: %w(create) do
    member do
      put :knew
      put :no_idea
      put :disagree
    end

    resource :comment, only: %w(create)
    resource :vote,    only: %w(create)
    resource :abuse,   only: %w(create)
  end

  match "pages/:action", to: "pages", action: /[a-z-]+/
  match "profile/:login", to: "failings#index", as: :profile

  resource :invitations, only: %w(new create)
  # root to: "emails#new"

  root to: "pages#root"
end
