class AddMissingFieldsToWeb < ActiveRecord::Migration
  def change
  	add_column :bikes, :web_display_image, :string
  end
end
