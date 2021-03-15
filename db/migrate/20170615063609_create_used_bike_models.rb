class CreateUsedBikeModels < ActiveRecord::Migration
  def change
    create_table :used_bike_models do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
