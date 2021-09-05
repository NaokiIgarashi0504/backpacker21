Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users
  root to: 'articles#index'
  get 'article_comment_replies_path', to: 'areplies#create'
  get 'comment_replies', to: 'areplies#create'

  resources :articles do
    collection do
      get 'search'
    end
    resources :comments, only: :create do
      resources :replies, only: :create
    end
  end

  resources :comments, only: :create do
    resources :replies, only: :create
  end

  resources :articles, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :users, only: :show
end
