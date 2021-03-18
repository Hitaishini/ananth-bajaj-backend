class CreateWebBannner < ActiveRecord::Migration[5.1]
  def change
      create_table :web_banners do |t|
      t.string :image
      t.string :s3_image_url
      t.boolean :active, :boolean, default: true
      t.integer :display_order, :integer
      t.timestamps null: false
    end
  end
end