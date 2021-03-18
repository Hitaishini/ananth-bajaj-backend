class AddBikeIdToMyBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :my_bikes, :bike_id, :integer
  end
end
