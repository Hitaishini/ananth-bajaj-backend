class CreateSpecifications < ActiveRecord::Migration[5.1]
  def change
    create_table :specifications do |t|
      t.string :name
      t.integer :specification_type_id
      t.integer :bike_id
      t.string :value
      t.boolean :active

      t.timestamps null: false
    end
  end
end
