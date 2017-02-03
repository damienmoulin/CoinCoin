class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = Article.find(params[:article])

    @comment.save

    redirect_to article_path(params[:article])
  end

  private
  def comment_params
    params.require(:comment).permit(:article, :message)
  end
end
