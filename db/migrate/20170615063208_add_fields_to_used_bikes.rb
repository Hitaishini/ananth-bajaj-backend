class AddFieldsToUsedBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bikes, :user_id, :integer
  	add_column :used_bikes, :used_bike_model_id, :integer
  end
end
