class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @user = User.find(@comment.user_id)
      ActionCable.server.broadcast 'comment_channel', {content: @comment, nickname: @user.nickname, created_at: @comment.created_at.strftime('%Y/%m/%d %H:%M:%S') }
    end
    # redirect_to "/products/#{@comment.product.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end