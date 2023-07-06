Rails.application.routes.draw do
  get 'general_shopping_lists/index'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root 'recipes#index'
  get '/recipes/public', to: 'recipes#public', as: 'public_recipes'
  resources :foods, only: [:index, :new, :create, :destroy]
  
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
    resources :foods, only: [:new, :create]
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  
  resources  :public, only: [:index, :show]
  get '/general_shopping_list', to: 'shoppinglists#index'

end
