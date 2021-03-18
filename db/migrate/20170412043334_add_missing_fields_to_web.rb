class AddMissingFieldsToWeb < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :web_display_image, :string
  end
end
