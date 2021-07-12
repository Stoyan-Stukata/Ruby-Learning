Rails.application.routes.draw do
  root "books#index"

  resources :books do
    resources :comments
  end
end
