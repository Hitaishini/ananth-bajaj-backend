class AddNotificationTemplateIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :notification_template_id, :integer
  end
end
