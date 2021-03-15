class AddStatusToTestRides < ActiveRecord::Migration
  def change
    add_column :test_rides, :status, :string, default: 'Active'
  end
end
