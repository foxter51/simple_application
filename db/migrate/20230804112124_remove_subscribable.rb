class RemoveSubscribable < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :subscribable_type
    remove_column :subscriptions, :subscribable_id
  end
end
