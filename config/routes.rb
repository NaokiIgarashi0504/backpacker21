Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'articles#index'
  resources :articles

  resources :articles do
    resources :comments, only: :create
    ollection do
      get 'search'
    end
  end
  resources :users, only: :show
end
