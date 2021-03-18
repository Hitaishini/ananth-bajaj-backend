class AddNotificationTemplateIdToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :notification_template_id, :integer
  end
end
