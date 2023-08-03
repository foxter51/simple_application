# Represents User controller
class UsersController < ApplicationController
  include Pagy::Backend

  before_action :set_user

  def show
    @pagy, @posts = pagy(@user.posts)
  end

  def set_user
    @user ||= User.find_by(id: params[:id])
  end
end
