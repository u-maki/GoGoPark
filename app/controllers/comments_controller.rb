class CommentsController < ApplicationController
  def new
    if params[:park_id]
      @park = Park.find(params[:park_id])
      @comment = @park.comments.build
    elsif params[:place_id]
      @place_id = params[:place_id]
      @comment = Comment.new(google_place_id: @place_id)
    else
      flash[:alert] = "公園情報が見つかりません。"
      redirect_to root_path
    end
  end

  def create
    if params[:park_id]
      @park = Park.find(params[:park_id])
      @comment = @park.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:notice] = "コメントを投稿しました。"
        redirect_to park_path(@park)
      else
        flash[:alert] = "コメントの投稿に失敗しました。"
        render :new
      end
    elsif params[:place_id]
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      @comment.google_place_id = params[:place_id]

      if @comment.save
        flash[:notice] = "コメントを投稿しました。"
        redirect_to google_park_path(place_id: params[:place_id])
      else
        flash[:alert] = "コメントの投稿に失敗しました。"
        render :new
      end
    else
      flash[:alert] = "コメントを投稿できませんでした。"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
