class AddExchangeToSellBikes < ActiveRecord::Migration
  def change
  	add_column :used_bikes, :exchange, :boolean, default: false
  end
end
