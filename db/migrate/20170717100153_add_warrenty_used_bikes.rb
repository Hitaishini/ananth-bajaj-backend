class AddWarrentyUsedBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bikes, :under_warrenty, :boolean, default: true
  end
end
