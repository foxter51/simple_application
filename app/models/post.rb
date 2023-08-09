# Represents Post model
class Post < ApplicationRecord
  include PgSearch::Model

  multisearchable against: [:title, :body]

  after_create :notify_subscribers
  after_save :reindex

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy, counter_cache: :likes_count

  has_one_attached :pic

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 255 }

  def notify_subscribers
    subscribers = user.subscribers

    subscribers.each do |subscriber|
      SubscriptionMailer.new_post_event_send(self, subscriber.subscriber).deliver
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id likes_count title updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments likes pic_attachment pic_blob user]
  end
  
  private

  def reindex
    PgSearch::Multisearch.rebuild(Post)
  end
end
