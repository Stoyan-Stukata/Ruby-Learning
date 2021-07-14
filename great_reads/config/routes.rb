Rails.application.routes.draw do
  root 'books#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :books
end
