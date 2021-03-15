class CreateBookingSlots < ActiveRecord::Migration
  def change
    create_table :booking_slots do |t|
      t.string :dealer_location
      t.string :category
      t.integer :total_slots

      t.timestamps null: false
    end
  end
end
