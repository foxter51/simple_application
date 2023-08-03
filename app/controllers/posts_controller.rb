# Represents tests controller
class PostsController < ApplicationController
  include Pagy::Backend
  before_action :set_post, except: %(index new create)
  before_action :set_post_policy, except: %(index new create)

  def index
    authorize Post
    @pagy, @posts = pagy(Post.all)
  end

  def new
    authorize Post
    @post = Post.new
  end

  def create
    authorize Post
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

  def set_post
    @post ||= Post.find_by(id: params[:id])
  end

  def set_post_policy
    authorize @post if @post.present?
  end

  def post_params
    params.require(:post).permit(:title, :body, :pic)
  end
end
