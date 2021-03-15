class AddImageUrlToMyBikes < ActiveRecord::Migration
  def change
  	 add_column :my_bikes, :my_bike_image_url, :string 
  end
end
