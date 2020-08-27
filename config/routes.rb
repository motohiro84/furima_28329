Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'products#index'
  resources :products do
    resources :orders, only:[:index, :create]
  end
  
end