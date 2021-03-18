class CreateUsedBikeModels < ActiveRecord::Migration[5.1]
  def change
    create_table :used_bike_models do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
