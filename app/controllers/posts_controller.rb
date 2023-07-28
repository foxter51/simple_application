# Represents tests controller
class PostsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.valid?
      @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.valid?
      @post.save
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
