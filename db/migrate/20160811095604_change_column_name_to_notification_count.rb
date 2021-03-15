class ChangeColumnNameToNotificationCount < ActiveRecord::Migration
  def change

  	rename_column :notification_counts, :test_drive_count, :bookings
  	rename_column :notification_counts, :offer_count, :offer
  	rename_column :notification_counts, :insurance_count, :events
  	rename_column :notification_counts, :service_count, :accessories
  	change_column_default(:notification_counts, :offer, 0)
  end
end
