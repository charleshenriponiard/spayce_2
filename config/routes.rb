Rails.application.routes.draw do
  # Routes pour devise
  devise_for :users, controllers: { registrations: "registrations",
                                    confirmations: "confirmations" }

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope '(:locale)', locale: /fr|en/ do
    root to: 'projects#new'
    # Routes pour multistep form
    resources :registration_steps, only: [:index, :show, :update]

    resources :projects, only: [:index, :create, :show], param: :slug do
      member do
        patch :canceled
      end
    end

    namespace :clients do
      resources :projects, only: :show, param: :slug
    end

    # Routes pour Stripe
    get '/stripe/dashboard', to: "stripes#dashboard_connect"
    get '/stripe/sign-up', to: "stripes#sign_up"
    mount StripeEvent::Engine, at: '/webhook'
    # Routes pour Sidekiq & BackgroundJob
  end
end
