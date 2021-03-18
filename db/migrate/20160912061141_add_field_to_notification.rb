class AddFieldToNotification < ActiveRecord::Migration[5.1]
  def change
  	add_column :notification_templates, :image, :string
  end
end
