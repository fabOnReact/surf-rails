require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :posts, :locations
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get "/pages/:page" => "pages#show", as: :page

  namespace :api do 
    namespace :v1 do 
      resources :posts, :locations
      devise_scope :user do
        post "/users/sign_in", to: "users/sessions#create"
        post "/users", to: "users/registrations#create"
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  root 'pages#show'
end
