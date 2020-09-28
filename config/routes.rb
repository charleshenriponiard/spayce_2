Rails.application.routes.draw do
  # Routes pour devise
  devise_for :users, controllers: { registrations: "registrations",
                                    confirmations: "confirmations" }

  root to: 'pages#home'

  # Routes pour multistep form
  resources :registration_steps, only: [:index, :show, :update]

  resources :projects, only: [:new, :create, :show, :destroy, :edit, :update]

  # Routes pour Stripe
  get '/stripe/dashboard', to: "stripes#dashboard_connect"
  get '/stripe/sign-up', to: "stripes#sign_up"
  mount StripeEvent::Engine, at: '/webhook'

  # Routes pour Sidekiq & BackgroundJob
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
