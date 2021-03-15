class ChangeColumnToTestrides < ActiveRecord::Migration
  def change
  	remove_column :test_rides, :status
  	add_column :test_rides, :status, :string, default: "Requested"
  end
end
