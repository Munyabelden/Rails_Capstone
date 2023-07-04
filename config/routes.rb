Rails.application.routes.draw do
  resources :foods
  devise_for :users
  resources :recipes
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root "foods#index"
end