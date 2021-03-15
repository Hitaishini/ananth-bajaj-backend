class AddFieldsToAccessories < ActiveRecord::Migration
  def change
  	add_column :accessories, :part_number, :string 
  	add_column :accessories, :size, :integer 
  	add_column :accessories, :price, :string 
  end
end
