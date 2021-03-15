class CreateUsedBikes < ActiveRecord::Migration
  def change
    create_table :used_bikes do |t|
      t.string :make_coompany
      t.string :model
      t.string :bike_type
      t.string :registration_number
      t.integer :manufacture_year
      t.integer :kms
      t.string :gear
      t.string :color
      t.string :ownership
      t.integer :price

      t.timestamps null: false
    end
  end
end
