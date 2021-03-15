class AddBikeIdToAccessories < ActiveRecord::Migration
  def change
  	add_column :accessories, :bike_id, :integer
  end
end
