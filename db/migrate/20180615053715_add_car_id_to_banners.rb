class AddCarIdToBanners < ActiveRecord::Migration[5.1]
  def change
  	add_column :banners, :bike_id, :integer
  	add_column :web_banners, :bike_id, :integer
  end
end
