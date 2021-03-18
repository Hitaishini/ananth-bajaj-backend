class CreateBulkNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :bulk_notifications do |t|
      t.text :content
      t.string :title
      t.string :category
      t.string :image

      t.timestamps null: false
    end
  end
end
