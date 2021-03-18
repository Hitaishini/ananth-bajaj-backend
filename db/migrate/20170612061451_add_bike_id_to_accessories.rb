class AddBikeIdToAccessories < ActiveRecord::Migration[5.1]
  def change
  	add_column :accessories, :bike_id, :integer
  end
end
