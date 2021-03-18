class CreateUsedBikeImages < ActiveRecord::Migration[5.1]
  def change
    create_table :used_bike_images do |t|
      t.string :image
      t.integer :used_bike_id

      t.timestamps null: false
    end
  end
end
