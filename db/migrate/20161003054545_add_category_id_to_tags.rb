class AddCategoryIdToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :accessory_category_id, :integer
  end
end
