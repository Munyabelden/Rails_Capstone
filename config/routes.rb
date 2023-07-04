Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'


  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    post 'publicize', on: :member
  end
    
end
