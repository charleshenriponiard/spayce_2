Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations",
                                    confirmations: "confirmations" }
  root to: 'pages#home'
  resources :registration_steps, only: [:index, :show, :update]
  get '/stripe/dashboard', to: "stripes#dashboard_connect"
  get '/stripe/sign-up', to: "stripes#sign_up"
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
