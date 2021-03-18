class CreateAccessoryTags < ActiveRecord::Migration[5.1]
  def change
    create_table :accessory_tags do |t|
      t.integer :accessory_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
