class CommentsController < ApplicationController
  before_action :set_park

  def create
    @comment = @park.comments.build(comment_params)
    @comment.user = current_user  # 現在のユーザーを設定

    if @comment.save
      redirect_to @park, notice: "コメントが投稿されました"
    else
      redirect_to @park, alert: "コメントの投稿に失敗しました"
    end
  end

  private

  def set_park
    @park = Park.find(params[:park_id])
  end

  def comment_params
    params.require(:comment).permit(:content)  # contentだけを許可
  end
end
