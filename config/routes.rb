Rails.application.routes.draw do
  post '/auth/login', to: 'auth#login'
  resources :admins, only: [:create]
  resources :bowling_houses, only: [:index, :create]
end
