Rails.application.routes.draw do
  get 'users/new'
  
  root 'tops#index'
end
