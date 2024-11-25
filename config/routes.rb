Rails.application.routes.draw do
  devise_for :users
  root to: "maps#index"

  # ユーザー編集・更新機能
  resources :users, only: [:edit, :update]

  # 公園リソース
  get 'parks/details/:place_id', to: 'parks#show', as: :google_park
  resources :parks do
    collection do
      get 'details/:place_id', to: 'parks#show', as: :google_park
    end
    resources :comments, only: [:create, :new, :index, :edit, :destroy, :update]
  end
  

  # コメントの独立した新規作成と作成ルート（Google Place ID 対応）
  resources :comments, only: [:new, :create]
end
