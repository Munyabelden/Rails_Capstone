Rails.application.routes.draw do
  devise_for :users
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
  end
    
end
