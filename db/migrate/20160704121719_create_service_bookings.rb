class CreateServiceBookings < ActiveRecord::Migration
  def change
    create_table :service_bookings do |t|
      t.integer :user_id
      t.integer :my_bike_id
      t.string :registration_number
      t.integer :kms
      t.date :service_date
      t.timestamp :service_time
      t.string :service_station
      t.text :comments
      t.string :service_type
      t.boolean :request_pick_up, default: false
      t.string :service_status, default: "Requested"

      t.timestamps null: false
    end
  end
end
