Rails.application.routes.draw do
  resources :paris

  root 'pages#home'

  devise_for :users

  # route pour link to action user admin
  resources :users do
    member do
      get :toggle_status
    end
  end


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


# test call action
resources :licences do
  member do
    get :toggle_creerlicences
    get :toggle_supprimerlicences
    get :toggle_calculrecuplicences
    get :toggle_calculrecuplicencesIndiv
  
  end
end

end
