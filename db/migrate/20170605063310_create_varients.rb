class CreateVarients < ActiveRecord::Migration
  def change
    create_table :varients do |t|
      t.string :varient_name
      t.string :fuel_type
      t.string :transmission_type
      t.integer :bike_id
      t.string :cc
      t.string :gear
      t.string :mileage
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
