class CreateBookingTimeControls < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_time_controls do |t|
      t.time :open_time
      t.time :end_time
      t.integer :days_prior
      t.string :weekday
      t.string :category
      t.boolean :active

      t.timestamps null: false
    end
  end
end
