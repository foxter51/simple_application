# Represents Comments controller
class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_post

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to @post
    else
      redirect_to @post, notice: "Comment was not added due to the error!"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment
      @comment.destroy
      redirect_to @post
    else
      redirect_to @post, notice: "Comment was not found!"
    end
  end

  private

  def set_post
    @post ||= Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user: current_user)
  end
end
