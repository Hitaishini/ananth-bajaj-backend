class AlterNameTypeBikeCategoryType < ActiveRecord::Migration[5.1]
  def change
  	rename_column :vehicle_faqs, :type, :cate_gory_type
  end
end
