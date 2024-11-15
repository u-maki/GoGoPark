Rails.application.routes.draw do
<<<<<<< Updated upstream
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
=======
  devise_for :users
  get 'maps/index'
  root to: "maps#index"
>>>>>>> Stashed changes
end
