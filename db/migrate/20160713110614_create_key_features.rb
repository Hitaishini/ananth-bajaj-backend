class CreateKeyFeatures < ActiveRecord::Migration
  def change
    create_table :key_features do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :bike_id
      t.integer :key_feature_type_id
      t.boolean :active,  default: true

      t.timestamps null: false
    end
  end
end
