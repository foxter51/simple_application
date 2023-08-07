class AddTwoColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :subscription_id, :integer
    add_column :subscriptions, :subscriber_id, :integer
  end
end
