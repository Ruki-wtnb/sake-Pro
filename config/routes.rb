Rails.application.routes.draw do
  get 'jsakes/new'
  get 'sessions/new'
  get 'users/new'
  
  root 'tops#index'
  resources :users
  resources :jsakes
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/mypage', to: 'mypages#index'
  
end