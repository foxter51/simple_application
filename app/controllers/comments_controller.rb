# Represents Comments controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @comments = post.comments
  end

  def new
    @comment = post.comments.new
  end

  def create
    @comment = post.comments.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to @post
    else
      redirect_to @post, notice: "Comment was not added due to the error!"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user: current_user)
  end
end
