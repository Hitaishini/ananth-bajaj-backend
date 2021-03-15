class RenameParentFromNotification < ActiveRecord::Migration
  def change
    rename_column :notifications, :parent, :parent_id
  end
end
