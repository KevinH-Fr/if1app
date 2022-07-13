Rails.application.routes.draw do

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

  #resources :licences do
  #  member do
  #    get :downgrade1
  #  end
  #end



  get 'home/index'
  get 'home/users'
  get 'home/role'


# test call action
resources :licences do
  member do
    get :toggle_creerlicence
    get :toggle_supprimerlicences
  end
end

end
