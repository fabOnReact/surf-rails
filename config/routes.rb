Rails.application.routes.draw do
  resources :posts, :locations
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'posts#landing'
end
