class AddStatusToTestRides < ActiveRecord::Migration[5.1]
  def change
    add_column :test_rides, :status, :string, default: 'Active'
  end
end
