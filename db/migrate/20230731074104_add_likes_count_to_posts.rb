# Represents Post migration to add likes_count
class AddLikesCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes_count, :integer, default: 0
  end
end
