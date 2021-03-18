class AddCompareVisibletoSpecifications < ActiveRecord::Migration[5.1]
  def change
    add_column :specifications, :compare_visible, :boolean, default: true
  	add_column :bike_colors, :compare_visible, :boolean, default: true
  end
end
