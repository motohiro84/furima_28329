Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :users, only:[:register] do
      get 'register', on: :collection
  end

  root to: 'products#index'
  resources :products do
    resources :orders,      only:[:index, :create]
    resources :comments,    only: :create
    resource :favorites,    only: [:create, :destroy] do
      post 'create_2',      on: :collection
      delete 'destroy_2',  on: :collection
    end
    collection do
      get 'search'
    end
  end

end