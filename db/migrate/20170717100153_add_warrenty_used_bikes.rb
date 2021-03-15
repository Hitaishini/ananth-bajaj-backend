class AddWarrentyUsedBikes < ActiveRecord::Migration
  def change
  	add_column :used_bikes, :under_warrenty, :boolean, default: true
  end
end
