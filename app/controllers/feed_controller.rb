# Represents Feed controller
class FeedController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @posts = pagy(current_user.subscribed_posts)
  end
end
