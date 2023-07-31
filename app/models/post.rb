# Represents Post model
class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :pic

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 255 }
end
