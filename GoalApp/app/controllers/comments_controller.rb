class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.save
    flash[:errors] = comment.errors.full_messages
    type = comment.commentable_type
    redirect_to send("#{type.downcase}_url", comment.commentable_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
