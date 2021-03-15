class CreateNotificationCounts < ActiveRecord::Migration
  def change
    create_table :notification_counts do |t|
      t.integer :user_id
      t.integer :test_drive_count
      t.integer :offer_count
      t.integer :insurance_count
      t.integer :service_count

      t.timestamps null: false
    end
  end
end
