Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"

  # ユーザー編集・更新機能
  resources :users, only: [:edit, :update]

  # 公園リソース
  resources :parks do
    # 公園に対するコメント機能
    resources :comments, only: [:create,:new]
    resources :parks, only: [:show]
    
  end
  get 'parks/details/:place_id', to: 'parks#show', as: :google_park
  get 'comments/new', to: 'comments#new', as: :new_comment
end
