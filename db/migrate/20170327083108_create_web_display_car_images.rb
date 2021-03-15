class CreateWebDisplayCarImages < ActiveRecord::Migration
  def change
    create_table :web_display_car_images do |t|
      t.string :image_url
      t.integer :car_id
      t.string :image

      t.timestamps null: false
    end
  end
end
