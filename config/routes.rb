Rails.application.routes.draw do
  post '/auth/login', to: 'auth#login'

  resources :admins, only: [:create]
  resources :bowling_houses, only: [:index, :create] do
    resources :lanes, only: [:index, :create, :update]
  end

  resources :lanes, only: [] do
    resources :games, only: [:index, :create, :update]
  end

  resources :users, only: [:index, :create]

  resources :games, only: [] do
    resources :users, only: [] do
      resources :frames, only: [:create]
    end
  end
end
