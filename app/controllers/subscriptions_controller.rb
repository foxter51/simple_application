# Represents Subscription controller
class SubscriptionsController < ApplicationController
  before_action :set_user

  def create
    if @user != current_user
      @user.add_subscriber(current_user)
      redirect_to @user, notice: "Successfully subscribed!"
    else
      redirect_to @user, notice: "You cannot subscribe yourself!"
    end
  end

  def destroy
    @user.remove_subscriber(current_user)
    redirect_to @user, notice: "Successfully unsubscribed!"
  end

  def set_user
    @user ||= User.find_by(id: params[:user_id])
  end
end
