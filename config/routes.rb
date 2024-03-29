Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :invoices
      resources :projects
      root to: "users#index"
    end
  # Routes pour devise
  devise_for :users, controllers: { registrations: "registrations",
                                  confirmations: "confirmations" }

  get '/account_confirmation', to: 'pages#account_confirmation', as: 'account_confirmation'
  get '/cgu', to: 'pages#cgu', as: 'cgu'
  get '/mentions_legales', to: 'pages#mentions_legales', as: 'mentions_legales'
  get '/politique_confidentialite', to: 'pages#politique_confidentialite', as: 'politique_confidentialite'


  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope '(:locale)', locale: /fr|en/ do
    root to: 'projects#new'
    get '/contact', to: 'messages#new', as: :contact
    resources :messages, only: :create
    # Routes pour multistep form
    resources :registration_steps, only: [:index, :show, :update]

    resources :projects, only: [:index, :create, :show], param: :slug do
      resources :invoices, only: :show
      member do
        patch :canceled
        get :confirmation
        get :sending
        get :promo_code
      end
    end

    namespace :clients do
      resources :projects, only: :show, param: :slug do
        member do
          get :create_checkout_session
        end
      end
    end

    # Routes pour Stripe
    get '/stripe/dashboard', to: "stripes#dashboard_connect"
    get '/stripe/sign-up', to: "stripes#sign_up"
    mount StripeEvent::Engine, at: '/webhook'
  end
end
