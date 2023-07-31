# Represents Comment migration to add likes_count
class AddLikesCountToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :likes_count, :integer, default: 0
  end
end
