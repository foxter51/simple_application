# Represents migration to add new fields to the model
class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :lastname, :string

    add_reference :users, :posts, foreign_key: true
    add_reference :users, :comments, foreign_key: true
  end
end
