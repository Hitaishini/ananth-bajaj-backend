class CreateDefaultBikeImages < ActiveRecord::Migration[5.1]
  def change
    create_table :default_bike_images do |t|
      t.string :image_url
      t.integer :bike_id

      t.timestamps null: false
    end
  end
end
