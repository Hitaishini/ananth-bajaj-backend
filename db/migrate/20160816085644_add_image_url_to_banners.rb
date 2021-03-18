class AddImageUrlToBanners < ActiveRecord::Migration[5.1]
  def change
  	add_column :banners, :image_host_url, :string
  	add_column :my_bikes, :image_host_url, :string
  end
end
