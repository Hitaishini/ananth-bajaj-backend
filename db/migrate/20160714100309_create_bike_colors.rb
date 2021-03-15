class CreateBikeColors < ActiveRecord::Migration
  def change
    create_table :bike_colors do |t|
      t.string :label
      t.string :color
      t.integer :bike_id
      t.string :image

      t.timestamps null: false
    end
  end
end
