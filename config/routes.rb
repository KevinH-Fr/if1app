Rails.application.routes.draw do
  resources :friends
  resources :saisons
  resources :divisions
  resources :circuits
  resources :events

  get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
