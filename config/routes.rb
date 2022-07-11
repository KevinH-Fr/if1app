Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users
  resources :users
  resources :friends
  resources :saisons
  resources :divisions
  resources :circuits
  resources :events
  resources :equipes
  resources :pilotes
  resources :resultats
  resources :classecuries
  resources :classements
  

  get 'home/index'
  get 'home/users'
  get 'home/role'
 # root 'home#index'
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
