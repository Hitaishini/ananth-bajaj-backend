class CreateAccessoryCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessory_categories do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :accessory_id

      t.timestamps null: false
    end
  end
end
