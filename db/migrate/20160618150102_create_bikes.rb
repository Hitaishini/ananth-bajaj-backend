class CreateBikes < ActiveRecord::Migration[5.1]
  def change
    create_table :bikes do |t|
      t.string :name
      t.text :description
      t.text :tagline
      t.boolean :available, default: true
      t.integer :bike_type_id

      t.timestamps null: false
    end
  end
end
