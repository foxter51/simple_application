# Represents User model
class User < ApplicationRecord
  rolify
  after_create :set_default_role, :set_admin_if_first

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :subscriptions, class_name: 'Subscription', foreign_key: :subscriber_id, counter_cache: :subscriptions_count
  has_many :subscribers, class_name: 'Subscription', foreign_key: :subscription_id, counter_cache: :subscribers_count

  has_one_attached :avatar

  def set_default_role
    add_role(:blogger) if roles.blank?
  end

  def set_admin_if_first
    add_role(:admin) if User.count == 1
  end

  def add_another_role(role)
    add_role(role) unless has_role? role
  end

  def add_subscriber(subscriber)
    subscribers.create(subscriber:)
    subscriber.subscribers.create(subscription: self)
  end

  def subscribed?(subscriber)
    subscribers.exists?(subscriber:)
  end

  def remove_subscriber(subscriber)
    subscribers.where(subscriber:).destroy_all
  end

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :registerable, :recoverable, :rememberable,
         :validatable
end
