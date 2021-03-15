class AddBikeIdToMyBikes < ActiveRecord::Migration
  def change
  	add_column :my_bikes, :bike_id, :integer
  end
end
