class AddFieldToSellUsedBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bikes, :for_sell, :boolean, default: false
  	add_column :used_bike_enquiries, :email, :string
  end
end
