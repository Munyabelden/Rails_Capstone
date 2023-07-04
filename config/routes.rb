Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index, :show] do
    resources :foods, only: [:index, :show, :new, :create, :destroy]
  end
end
