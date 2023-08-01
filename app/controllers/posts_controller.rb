# Represents tests controller
class PostsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, :post

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.valid?
      @post.save
      redirect_to @post
    else
      render :new, notice: "Check your post for validity!"
    end
  end

  def update
    @post.assign_attributes(post_params)

    if @post.valid?
      @post.save
      redirect_to @post
    else
      render :edit, notice: "Check your post for validity!"
    end
  end

  def destroy
    if @post
      @post.destroy
      redirect_to posts_path
    else
      redirect_to @post, notice: "Post was not found!"
    end
  end

  def show
    @post
  end

  def edit
    @post
  end

  private

  def post
    @post ||= Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
