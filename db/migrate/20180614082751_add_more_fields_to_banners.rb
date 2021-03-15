class AddMoreFieldsToBanners < ActiveRecord::Migration
  def change
  	add_column :banners, :button_text, :string
  	add_column :banners, :button_link_url, :string
  	add_column :banners, :button_color, :string
  end
end
