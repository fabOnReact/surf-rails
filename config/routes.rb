Rails.application.routes.draw do
  resources :posts, :locations
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get "/pages/:page" => "pages#show"
  root 'pages#show'
end
