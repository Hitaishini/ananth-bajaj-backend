class AddFieldToNotification < ActiveRecord::Migration
  def change
  	add_column :notification_templates, :image, :string
  end
end
