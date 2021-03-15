class CreateWebCarColors < ActiveRecord::Migration
  def change
    create_table :web_car_colors do |t|
      t.integer :car_id
      t.text :s3_image_url
      t.text :s3_pallet_image_url
      t.text :color_name

      t.timestamps null: false
    end
  end
end
  