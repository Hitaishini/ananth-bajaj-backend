class AddExtraFieldsToBikes < ActiveRecord::Migration
  def change
  	 add_column :default_bike_images, :web_s3_url, :string
  	 add_column :default_bike_images, :mobile_s3_url, :string
  	 add_column :default_bike_images, :overview_url, :string
  end
end
