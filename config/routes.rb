Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"

  # ユーザー編集・更新機能
  resources :users, only: [:edit, :update]

  # 公園リソース
  get 'parks/details/:place_id', to: 'parks#show', as: :google_park
  resources :parks do
    # 公園に対するコメント機能
    resources :comments, only: [:create, :new, :index] # 必要なアクションのみ定義
  end

  # コメントの独立した新規作成と作成ルート（Google Place ID 対応）
  resources :comments, only: [:new, :create]
end
