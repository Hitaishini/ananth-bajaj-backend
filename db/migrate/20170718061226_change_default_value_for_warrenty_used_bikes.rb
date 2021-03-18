class ChangeDefaultValueForWarrentyUsedBikes < ActiveRecord::Migration[5.1]
  def change
  	change_column :used_bikes, :under_warrenty, :boolean, :default => false
  end
end
