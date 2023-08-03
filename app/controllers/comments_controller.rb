# Represents Comments controller
class CommentsController < ApplicationController
  before_action :set_post, :set_comment_policy

  def new
    @comment = @post.comments.new
    set_comment_policy
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
    set_comment_policy
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

  def set_comment_policy
    authorize @comment if @comment.present?
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user: current_user)
  end
end
