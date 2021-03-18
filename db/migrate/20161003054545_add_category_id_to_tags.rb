class AddCategoryIdToTags < ActiveRecord::Migration[5.1]
  def change
  	add_column :tags, :accessory_category_id, :integer
  end
end
