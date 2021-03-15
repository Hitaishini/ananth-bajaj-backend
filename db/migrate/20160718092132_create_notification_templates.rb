class CreateNotificationTemplates < ActiveRecord::Migration
  def change
    create_table :notification_templates do |t|
      t.text :content
      t.string :title
      t.string :category
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
