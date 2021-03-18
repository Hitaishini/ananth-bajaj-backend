class RenameParentFromNotification < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :parent, :parent_id
  end
end
