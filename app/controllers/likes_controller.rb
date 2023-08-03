# Represents Likes controller
class LikesController < ApplicationController
  before_action :set_post, :set_like_policy

  def create
    @like = current_user.likes.new(like_params)
    if @like.valid?
      @like.save
      redirect_to @post
    else
      redirect_to @post, notice: "You have already liked this!"
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    set_like_policy
    if @like
      @like.destroy
      redirect_to @post
    else
      redirect_to @post, notice: "Like was not found!"
    end
  end

  private

  def set_post
    @post ||= Post.find_by(id: params[:post_id])
  end

  def set_like_policy
    authorize @like if @like.present?
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
