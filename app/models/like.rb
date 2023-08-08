# Represents Like model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id likeable_id likeable_type updated_at user_id]
  end
end
