class ChangeDefaultValueToTestRides < ActiveRecord::Migration
  def change
  	change_column :test_rides, :status, :string, :default => "Active"
  end
end
