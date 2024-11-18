Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"

  # ユーザー編集・更新機能
  resources :users, only: [:edit, :update]

  # 公園リソース
  resources :parks do
    # 公園に対するコメント機能
    resources :comments, only: [:create]
    resources :parks, only: [:show]
  end
end
