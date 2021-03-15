class CchangeDefaultValueTips < ActiveRecord::Migration
  def change
  	remove_column :notification_counts, :tips, :integer
  	add_column :notification_counts, :tips, :integer,  default: 0
  end
end
