class AddFieldToBikeColors < ActiveRecord::Migration
  def change
  	add_column :bike_colors, :color_pallet_s3, :string
  end
end
