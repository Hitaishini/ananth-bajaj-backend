class AddMoreFieldsToWebBanners < ActiveRecord::Migration[5.1]
  def change
  	add_column :web_banners, :button_text, :string
  	rename_column :web_banners, :redirect_to, :button_link_url
  	rename_column :web_banners, :car_id, :button_color
  	add_column :web_banners, :button_visible, :boolean ,default: true
  end
end
