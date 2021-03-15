class AddNewFieldsToRides < ActiveRecord::Migration
  def change
  	remove_column :rides, :assembly_time
  	remove_column :rides, :destination_time
  	add_column :rides, :title, :string
  	add_column :rides, :assembly_time, :text
  	add_column :rides, :destination_time, :text
  	add_column :rides, :check_points, :text
  end
end
