Rails.application.routes.draw do
	resources :picturese
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
	root 'pictures#new'
end
