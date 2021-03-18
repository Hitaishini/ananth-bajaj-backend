class AddTipsToNotification < ActiveRecord::Migration[5.1]
  def change
  	add_column :notification_counts, :tips, :integer
  end
end
