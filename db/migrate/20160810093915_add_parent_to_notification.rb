class AddParentToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :parent, :integer
  end
end
