class AddTipsToNotification < ActiveRecord::Migration
  def change
  	add_column :notification_counts, :tips, :integer
  end
end
