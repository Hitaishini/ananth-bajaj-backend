class AddRedirectAndCarIdToToWebBanners < ActiveRecord::Migration
  def change
  	add_column :web_banners, :car_id, :string
  		add_column :web_banners, :redirect_to, :string
  end
end
