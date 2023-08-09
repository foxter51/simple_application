# Represents Feed controller
class FeedController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @posts = pagy(current_user.subscribed_posts)
    raise SubscriptionsNotFoundException, 'Subscriptions not found' if @posts.empty?
  rescue SubscriptionsNotFoundException => e
    Rails.logger.error "Subscriptions are empty: #{e.message}"
    redirect_to posts_path, notice: e.message
  end
end
