class AddCountToNotificationCount < ActiveRecord::Migration[5.1]
  def change
    add_column :notification_counts, :count, :integer, default: 0
  end
end
