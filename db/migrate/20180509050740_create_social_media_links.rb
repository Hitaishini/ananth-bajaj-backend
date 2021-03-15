class CreateSocialMediaLinks < ActiveRecord::Migration
  def change
    create_table :social_media_links do |t|
      t.string :social_media_name
      t.string :social_media_url
      t.integer :display_order
      t.boolean :visible,             default: true

      t.timestamps null: false
    end
  end
end
