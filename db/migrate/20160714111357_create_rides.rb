class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.date :ride_date
      t.string :route
      t.string :distance
      t.timestamp :assembly_time
      t.string :assembly_location
      t.time :destination_time
      t.string :destination_location
      t.boolean :notify

      t.timestamps null: false
    end
  end
end
