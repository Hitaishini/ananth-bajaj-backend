class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :bike_id
      t.text :image

      t.timestamps null: false
    end
  end
end
