Rails.application.routes.draw do

  devise_for :users
  root to: 'products#index'
  resources :products
  resources :orders, only:[:index, :new, :create]

end