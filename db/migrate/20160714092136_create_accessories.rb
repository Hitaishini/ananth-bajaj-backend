class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :title
      t.text :description
      t.string :tag
      t.string :image

      t.timestamps null: false
    end
  end
end
