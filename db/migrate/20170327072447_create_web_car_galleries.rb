class CreateWebCarGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :web_car_galleries do |t|
      t.integer :car_id
      t.text :image_url
      t.text :diff_int_ext

      t.timestamps null: false
    end
  end
end


