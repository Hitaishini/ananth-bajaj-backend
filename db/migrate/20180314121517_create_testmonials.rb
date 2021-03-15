class CreateTestmonials < ActiveRecord::Migration
  def change
    create_table :testmonials do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
