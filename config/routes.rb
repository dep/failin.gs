FailinGs::Application.routes.draw do
  resource :user_session, except: :update
  get "login", to: "user_sessions#new", as: :login
  match "logout", to: "user_sessions#destroy", method: :delete, as: :logout

  match 'auth/failure',            to: 'authentications#failure'
  match 'auth/:provider/callback', to: 'authentications#callback'
  match 'auth/:provider/unlink',   to: 'authentications#unlink'
  delete 'auth/:provider/destroy', to: 'authentications#destroy',
    as: :auth_delete

  resource :account, controller: "users", only: %w(create edit update destroy) do
    get  "unsubscribe" => "users#unsubscribe",  as: :unsubscribe
    post "unsubscribe" => "users#unsubscribed", as: :unsubscribed
  end
  get  "account" => redirect("/account/edit")

  resources :preferences

  resource :password, only: %w(new create edit update destroy)

  scope "profile/:login" do
    resources :failings, only: %w(create show) do
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
  end

  resources :friends, only: %w(index create destroy) do
    collection do
      get :bookmarks
      get :twitter
      # get :facebook
      # get :email
    end
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
