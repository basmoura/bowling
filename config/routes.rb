Rails.application.routes.draw do
  resources :admins, only: [:create]
end
