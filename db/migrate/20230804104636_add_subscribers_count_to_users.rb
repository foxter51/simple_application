class AddSubscribersCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscribers_count, :integer
  end
end
