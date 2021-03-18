class CchangeDefaultValueTips < ActiveRecord::Migration[5.1]
  def change
  	remove_column :notification_counts, :tips, :integer
  	add_column :notification_counts, :tips, :integer,  default: 0
  end
end
