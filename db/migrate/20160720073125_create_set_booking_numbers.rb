class CreateSetBookingNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :set_booking_numbers do |t|
      t.string :booking_number
      t.string :category
      t.string :label
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
