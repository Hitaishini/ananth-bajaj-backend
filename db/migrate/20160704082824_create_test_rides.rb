class CreateTestRides < ActiveRecord::Migration
  def change
    create_table :test_rides do |t|
      t.integer :user_id
      t.string :name
      t.string :mobile
      t.string :email
      t.text :address
      t.boolean :request_pick_up, default: false
      t.boolean :test_ride_done, default: false
      t.boolean :test_ride_confirmed, default: false
      t.string :bike
      t.date :ride_date, null: false
      t.timestamp :ride_time, null: false
      t.string :location

      t.timestamps null: false
    end
  end
end
