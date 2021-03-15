class AddColumnsToAccessories < ActiveRecord::Migration
  def change
  	add_column :accessories, :brand, :string
  	add_column :accessory_categories, :brand, :string
  end
end
