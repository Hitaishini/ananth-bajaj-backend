class AddExchangeToSellBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bikes, :exchange, :boolean, default: false
  end
end
