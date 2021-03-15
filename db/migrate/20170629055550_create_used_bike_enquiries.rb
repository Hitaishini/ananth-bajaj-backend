class CreateUsedBikeEnquiries < ActiveRecord::Migration
  def change
    create_table :used_bike_enquiries do |t|
      t.string :model
      t.string :registration_number
      t.integer :kms
      t.integer :manufacture_year
      t.string :dealer_number
      t.integer :price
      t.string :dealer_location
      t.text :comment

      t.timestamps null: false
    end
  end
end
