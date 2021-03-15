class AddFieldToFullImage < ActiveRecord::Migration
  def change
  	 add_column :model_full_images, :bike_id, :integer
  end
end
