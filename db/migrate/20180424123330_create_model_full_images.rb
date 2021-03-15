class CreateModelFullImages < ActiveRecord::Migration
  def change
    create_table :model_full_images do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
