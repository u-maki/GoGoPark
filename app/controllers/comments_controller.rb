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
      @comment.google_place_id = params[:place_id]
    else
      @comment.park_id = params[:park_id]
    end

    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to params[:place_id] ? google_park_path(place_id: params[:place_id]) : park_path(@comment.park_id)
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      render :new
    end
  end

  

  private

  def comment_params
    params.require(:comment).permit(:content, :toilet, :diaper_changing_station, :vending_machine, :shop, :parking, :slide, :swing, photos: [])
  end
end
