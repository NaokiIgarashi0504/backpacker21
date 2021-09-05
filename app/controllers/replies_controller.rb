class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      redirect_to "/comments/#{@reply.comment.id}"
    else
      @article = @comment.article
      @comments = @article.comments
      @replies = @comments.replies
      render "articles/show"
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:reply).merge(user_id: current_user.id, comment_id: params[:comment_id])
  end
end
