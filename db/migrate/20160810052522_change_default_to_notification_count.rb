class ChangeDefaultToNotificationCount < ActiveRecord::Migration
  def change
  	change_column_default(:notification_counts, :service_count, 0)
  	change_column_default(:notification_counts, :test_drive_count, 0)
  	change_column_default(:notification_counts, :insurance_count, 0)
  end
end
