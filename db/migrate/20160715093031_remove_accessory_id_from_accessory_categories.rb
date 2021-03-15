class RemoveAccessoryIdFromAccessoryCategories < ActiveRecord::Migration
  def change
  	remove_column :accessory_categories, :accessory_id
  	add_column :accessories, :accessory_category_id, :integer 
  end
end
