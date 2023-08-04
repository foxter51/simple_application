class AddSubscriptionsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscriptions_count, :integer
  end
end
