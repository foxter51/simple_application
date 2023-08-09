require_relative '../exceptions/self_subscription_exception'

# Represents Subscription controller
class SubscriptionsController < ApplicationController
  before_action :set_user

  def create
    raise SelfSubscriptionException, 'Self subscription error' if @user == current_user

    @user.add_subscriber(current_user)
    redirect_to @user, notice: "Successfully subscribed!"
  rescue SelfSubscriptionException => e
    Rails.logger.error "You cannot subscribe yourself: #{e.message}"
    redirect_to @user, notice: e.message
  end

  def destroy
    @user.remove_subscriber(current_user)
    redirect_to @user, notice: "Successfully unsubscribed!"
  end

  def set_user
    @user ||= User.find_by(id: params[:user_id])
  end
end
