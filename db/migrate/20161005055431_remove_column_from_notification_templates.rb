class RemoveColumnFromNotificationTemplates < ActiveRecord::Migration
  def change
  	remove_column :notification_templates, :image
  	add_column :notifications, :bulk_notification_id, :integer
  end
end
