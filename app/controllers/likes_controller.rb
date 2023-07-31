# Represents Likes controller
class LikesController < ApplicationController
  before_action :authenticate_user!, :post

  def create
    @like = current_user.likes.new(like_params)
    if @like.valid?
      @like.save
      @like.likeable.increment!(:likes_count)
      redirect_to @post
    else
      redirect_to @post, notice: "You have already liked this!"
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    if @like
      @like.likeable.decrement!(:likes_count)
      @like.destroy
      redirect_to @post
    else
      redirect_to @post, notice: "Like was not found!"
    end
  end

  private

  def post
    @post ||= Post.find_by(id: params[:post_id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
