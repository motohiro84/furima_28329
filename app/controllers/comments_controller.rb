class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @product = Product.find(params[:product_id])
    @user = User.find(@comment.user_id)
    @comments = Product.find(params[:product_id]).comments.includes(:user)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', { content: @comment, nickname: @user.nickname, created_at: @comment.created_at.strftime('%Y/%m/%d %H:%M:%S') }
    else
      render 'products/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
