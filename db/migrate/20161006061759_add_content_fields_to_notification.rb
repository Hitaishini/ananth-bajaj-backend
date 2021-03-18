class AddContentFieldsToNotification < ActiveRecord::Migration[5.1]
  def change
  	 add_column :notifications, :content, :text
     add_column :notifications, :title, :string
  end
end
