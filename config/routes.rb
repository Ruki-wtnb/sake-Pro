Rails.application.routes.draw do
  get 'users/new'
  
  root 'tops#index'
  resources :users
end
