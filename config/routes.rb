Rails.application.routes.draw do

  devise_for :users
  root to: "maps#index"
  resources :users, only: [:edit, :update]
end
