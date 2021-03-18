class AddBikeColorToModelFullImages < ActiveRecord::Migration[5.1]
  def change
  	add_column :model_full_images, :color_name, :string
  end
end
