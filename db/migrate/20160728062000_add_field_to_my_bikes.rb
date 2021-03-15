class AddFieldToMyBikes < ActiveRecord::Migration
  def change
  	add_column :my_bikes, :default_bike_image_id, :integer 
  	add_column :bikes, :display_order, :integer 
  end
end
