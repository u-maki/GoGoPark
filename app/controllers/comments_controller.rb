class CommentsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ許可
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  def new
    if params[:place_id]
      @place_id = params[:place_id]
      @comment = Comment.new(google_place_id: @place_id)
    else
      flash[:alert] = "公園情報が見つかりません。"
      redirect_to root_path
    end
  end

  def create
    @comment = current_user.comments.build(comment_params) # 重複削除
  
    if params[:place_id]
      # Google Places API から公園データを取得
      @park = Park.fetch_from_google_places(params[:place_id])
      if @park.nil? || @park.invalid?
        flash[:alert] = "公園情報の取得に失敗しました。"
        redirect_to root_path and return
      end
  
      @comment.park = @park
      @comment.google_place_id = params[:place_id]
    elsif params[:park_id].present?
      # ローカルの公園データを使用
      @park = Park.find(params[:park_id])
      @comment.park = @park
    else
      flash[:alert] = "公園情報が不正です。"
      redirect_to root_path and return
    end
  
    # コメント保存処理
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
      # Google Place ID を使った場合とローカルの公園IDを使った場合でリダイレクト先を切り替え
      redirect_to params[:place_id] ? google_park_parks_path(place_id: params[:place_id]) : park_path(@park)
    else
      flash.now[:failure] = "コメントの投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end
  

  def index
    @park = Park.find(params[:park_id])
    if params[:place_id]
      # Google Place ID を使って公園情報を取得
      @park = Park.find_by(google_place_id: params[:place_id])
      unless @park
        flash[:alert] = "公園情報が見つかりません。"
        redirect_to root_path and return
      end
    elsif params[:park_id]
      # ローカルの公園IDを使って公園情報を取得
      @park = Park.find(params[:park_id])
    else
      flash[:alert] = "公園情報が指定されていません。"
      redirect_to root_path and return
    end
  
    # 公園に関連するコメントを取得
    @comments = @park.comments
  end
  

  def edit
    @park = @comment.park || Park.find_by(google_place_id: params[:place_id])
    
  end
  

  def update
    if @comment.update(comment_params)
      flash[:success] = "コメントを更新しました。"
      # 公園の種類に応じて適切な詳細ページにリダイレクト
      if @comment.google_place_id
        redirect_to google_park_parks_path(place_id: @comment.google_place_id)
      else
        redirect_to park_path(@comment.park_id)
      end
    else
      flash.now[:failure] = "コメントの更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end
  
  

  def destroy
    @park = Park.find(params[:park_id])
    @comment.destroy
    redirect_to google_park_parks_path(place_id: @comment.google_place_id)
  end

  

  private

  def authorize_user
    unless @comment.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to root_path
    end
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :content,
      :toilet,
      :diaper_changing_station,
      :vending_machine,
      :shop,
      :parking,
      :slide,
      :swing,
      photos: []
      ).tap do |whitelisted|
        # チェックボックスのパラメータをbooleanに変換
        %w[toilet diaper_changing_station vending_machine shop parking slide swing].each do |field|
          whitelisted[field] = ActiveRecord::Type::Boolean.new.cast(whitelisted[field])
        end
    end
  end
end
