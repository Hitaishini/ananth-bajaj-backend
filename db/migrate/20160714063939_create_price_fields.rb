class CreatePriceFields < ActiveRecord::Migration[5.1]
  def change
    create_table :price_fields do |t|
      t.string :name
      t.integer :display_order
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
