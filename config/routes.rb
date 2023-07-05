Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'recipes#index'
  
  resources :foods, only: [:index, :new, :create]
  
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
    resources :foods, only: [:new, :create]
    resources :recipe_foods, only: [:new, :create]
  end
  get 'recipes/public', to: 'recipes#public', as: 'public_recipes'

end
