class AddImageUrlToMyBikes < ActiveRecord::Migration[5.1]
  def change
  	 add_column :my_bikes, :my_bike_image_url, :string 
  end
end
