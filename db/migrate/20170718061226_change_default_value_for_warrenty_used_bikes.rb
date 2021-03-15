class ChangeDefaultValueForWarrentyUsedBikes < ActiveRecord::Migration
  def change
  	change_column :used_bikes, :under_warrenty, :boolean, :default => false
  end
end
