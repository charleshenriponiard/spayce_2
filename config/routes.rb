Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: "omniauth_callbacks",
                                    confirmations: "confirmations" }
  root to: 'pages#home'

  resources :registration_steps, only: [:index, :show, :update]

  # get "/users/stripe-connect", to: "stripes#sign_up", as: "stripe_connect"

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
