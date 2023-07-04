Rails.application.routes.draw do
  resources :foods
  devise_for :users
  resources :recipes
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'foods#index'
  root 'recipes#index'

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
  end
  get 'recipes/public', to: 'recipes#public', as: 'public_recipes'  
end
