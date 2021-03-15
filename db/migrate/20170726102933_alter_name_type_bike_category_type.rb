class AlterNameTypeBikeCategoryType < ActiveRecord::Migration
  def change
  	rename_column :vehicle_faqs, :type, :cate_gory_type
  end
end
