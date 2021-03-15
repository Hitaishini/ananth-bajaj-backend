class AddContentFieldsToNotification < ActiveRecord::Migration
  def change
  	 add_column :notifications, :content, :text
     add_column :notifications, :title, :string
  end
end
