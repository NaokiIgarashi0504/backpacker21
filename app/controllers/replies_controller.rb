class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @comment = @reply.comment
    if @reply.save
      redirect_to "/articles/#{@comment.article.id}"
    else
      redirect_to "/articles/#{@comment.article.id}"
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:reply).merge(user_id: current_user.id, comment_id: params[:comment_id])
  end

end
