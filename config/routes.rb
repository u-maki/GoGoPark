Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"

  # ユーザー編集・更新機能
  resources :users, only: [:edit, :update]

  # 公園リソース
  get 'parks/details/:place_id', to: 'parks#show', as: :google_park
  resources :parks do
    # 公園に対するコメント機能
    resources :comments, only: [:create, :new] # 必要なアクションのみ定義
  end

  # Google Place ID を利用したコメント機能
  get 'comments/new', to: 'comments#new', as: :new_comment
  post 'comments', to: 'comments#create', as: :create_comment # 独立したコメント作成ルート
end

