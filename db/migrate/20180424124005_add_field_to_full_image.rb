class AddFieldToFullImage < ActiveRecord::Migration[5.1]
  def change
  	 add_column :model_full_images, :bike_id, :integer
  end
end
