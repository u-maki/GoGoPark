class CommentsController < ApplicationController
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
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if params[:place_id]
      @park = Park.fetch_from_google_places(params[:place_id])
      if @park.nil? || @park.invalid?
         flash[:alert] = "公園情報の取得に失敗しました。"
         redirect_to root_path and return
      end     
      @comment.park = @park
      @comment.google_place_id = params[:place_id]
    elsif params[:park_id].present?
      @comment.park_id = params[:park_id]
    else
      flash[:alert] = "公園情報が不正です。"
      redirect_to root_path and return
    end

    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
      #redirect_to park_path(@comment.park), notice: 'コメントが投稿されました。'
      redirect_to params[:place_id] ? google_park_path(place_id: params[:place_id]) : park_path(@comment.park_id)
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @park = Park.find(params[:park_id])
    @comments = @park.comments
  end
  

  private

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
