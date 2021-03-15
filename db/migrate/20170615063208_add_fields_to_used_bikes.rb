class AddFieldsToUsedBikes < ActiveRecord::Migration
  def change
  	add_column :used_bikes, :user_id, :integer
  	add_column :used_bikes, :used_bike_model_id, :integer
  end
end
