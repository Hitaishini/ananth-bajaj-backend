class CreateBookingSlotControls < ActiveRecord::Migration
  def change
    create_table :booking_slot_controls do |t|
      t.string :dealer_location
      t.string :category
      t.integer :available_slots
      t.date :booking_date

      t.timestamps null: false
    end
  end
end
