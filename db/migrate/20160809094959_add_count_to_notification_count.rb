class AddCountToNotificationCount < ActiveRecord::Migration
  def change
    add_column :notification_counts, :count, :integer, default: 0
  end
end
