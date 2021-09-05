class RepliesController < ApplicationController
  def create
    @reply = Reply.new(reply_params)
    @comment = @reply.comment
    if @reply.save
      redirect_to "/articles/#{@comment.article.id}"
    else
      @comment = @reply.comment
      @replies = @comment.replies
      render "articles/show"
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:reply).merge(user_id: current_user.id, comment_id: params[:comment_id])
  end

  # def comment_params
  #   params.require(:comment).permit(:comment).merge(user_id: current_user.id, article_id: params[:article_id])
  # end

end
