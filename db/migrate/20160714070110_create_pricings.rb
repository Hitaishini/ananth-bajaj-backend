class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :price_field_id
      t.string :value
      t.integer :bike_id
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
