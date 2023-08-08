# Represents subscription model
class Subscription < ApplicationRecord
  after_create :notify_subscribers

  belongs_to :subscriber, counter_cache: :subscribers_count, class_name: 'User'
  belongs_to :subscription, counter_cache: :subscriptions_count, class_name: 'User'

  def notify_subscribers
    SubscriptionMailer.new_subscription(subscriber).deliver
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id subscriber_id subscription_id updated_at]
  end
end
