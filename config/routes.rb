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
  root 'pages#show'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do 
    namespace :v1 do 
      resources :posts
    end
  end
end
