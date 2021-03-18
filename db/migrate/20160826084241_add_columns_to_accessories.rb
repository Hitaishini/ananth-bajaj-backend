class AddColumnsToAccessories < ActiveRecord::Migration[5.1]
  def change
  	add_column :accessories, :brand, :string
  	add_column :accessory_categories, :brand, :string
  end
end
