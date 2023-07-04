Rails.application.routes.draw do
  get 'foods/index'
  get 'foods/show'
  get 'foods/new'
  devise_for :users
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    patch 'publicize', on: :member
  end
    
end
