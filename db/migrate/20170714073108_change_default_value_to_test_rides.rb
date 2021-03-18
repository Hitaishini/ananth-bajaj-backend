class ChangeDefaultValueToTestRides < ActiveRecord::Migration[5.1]
  def change
  	change_column :test_rides, :status, :string, :default => "Active"
  end
end
