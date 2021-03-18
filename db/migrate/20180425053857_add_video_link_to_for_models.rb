class AddVideoLinkToForModels < ActiveRecord::Migration[5.1]
  def change
  	add_column :model_full_images, :video_url, :string
  	add_column :model_full_images, :category, :string
  end
end
