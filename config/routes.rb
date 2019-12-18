Rails.application.routes.draw do
  get 'comments/new'
  get 'jsakes/new'
  get 'sessions/new'
  get 'users/new'
  
  root 'tops#index'
  get 'tops/result'
  
  resources :tops do
    collection{post "search"}
  end
  
  resources :users
  resources :jsakes
  resources :comments
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/mypage', to: 'mypages#index'
  post '/favorites', to: "mypages#create"
  delete '/unfavorites', to: "mypages#destroy"
end