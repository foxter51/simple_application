# Represents Comment class
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :likes, as: :likeable, dependent: :destroy, counter_cache: :likes_count

  validates :text, presence: true, length: { maximum: 100 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id likes_count post_id text updated_at user_id]
  end
end
