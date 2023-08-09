# Represents User model
class User < ApplicationRecord
  include PgSearch::Model

  multisearchable against: [:name, :lastname]

  rolify
  after_create :set_default_role, :set_admin_if_first
  after_save :reindex

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

  def self.ransackable_attributes(_auth_object = nil)
    %w[confirmation_sent_at confirmation_token confirmed_at created_at description email encrypted_password id lastname name remember_created_at
       reset_password_sent_at reset_password_token subscribers_count subscriptions_count unconfirmed_email updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[avatar_attachment avatar_blob comments likes posts roles subscribers subscriptions]
  end
  
  def subscribed_posts
    Post.where(user: subscriptions.map(&:subscription))
  end

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :registerable, :recoverable, :rememberable,
         :validatable

  private

  def reindex
    PgSearch::Multisearch.rebuild(User)
  end
end
