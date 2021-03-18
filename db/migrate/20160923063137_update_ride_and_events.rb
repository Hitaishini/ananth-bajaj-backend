class UpdateRideAndEvents < ActiveRecord::Migration[5.1]
  def change
  	add_column :rides, :coordinator_name, :string, default: 'N/A'
  	add_column :events, :coordinator_name, :string, default: 'N/A'
  	add_column :rides, :coordinator_mobile, :integer, default: 0
  	add_column :events, :coordinator_mobile, :integer, default: 0
  end
end
