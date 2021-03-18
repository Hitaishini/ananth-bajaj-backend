class AddVarientIdToFeaturesAndPriceValues < ActiveRecord::Migration[5.1]
  def change
  	add_column :pricings, :varient_id, :integer
  	add_column :key_features, :varient_id, :integer
  end
end
