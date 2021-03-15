class CreateAccessoryTags < ActiveRecord::Migration
  def change
    create_table :accessory_tags do |t|
      t.integer :accessory_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
