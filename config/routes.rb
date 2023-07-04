Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
  end
  get 'recipes/public', to: 'recipes#public', as: 'public_recipes'  
    
end
