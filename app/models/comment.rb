# Represents Comment class
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :likes, as: :likeable, dependent: :destroy, counter_cache: :likes_count

  validates :text, presence: true, length: { maximum: 100 }
end
