class AddBikeColorToModelFullImages < ActiveRecord::Migration
  def change
  	add_column :model_full_images, :color_name, :string
  end
end
