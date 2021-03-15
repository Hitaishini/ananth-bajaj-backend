class AddParentToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :parent, :integer
  end
end
