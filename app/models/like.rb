# Represents Like model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }

  after_create :increase_like_count
  after_destroy :decrease_like_count

  def increase_like_count
    likeable.likes_count += 1
    likeable.save!
  end

  def decrease_like_count
    likeable.likes_count -= 1
    likeable.save!
  end
end
