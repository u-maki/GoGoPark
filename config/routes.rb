Rails.application.routes.draw do

  devise_for :users
  get 'maps/index'
  root to: "maps#index"
end
