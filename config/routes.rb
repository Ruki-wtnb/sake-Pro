Rails.application.routes.draw do
  
  get 'vote/create'
  get 'vote/destroy'
  #views/tops/indexに遷移
  root 'tops#index'
  get 'tops/result'
  
  resources :tops do
    collection{post "search"}
  end
  
  resources :users
  resources :jsakes
  resources :comments
  resources :account_activations, only: [:edit]

  #ログインパスsessionコントローラのnewアクションへ
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/mypage', to: 'mypages#index'
  post '/favorites', to: "mypages#create"
  delete '/unfavorites', to: "mypages#destroy"
end