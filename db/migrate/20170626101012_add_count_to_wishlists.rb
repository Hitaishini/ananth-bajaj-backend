class AddCountToWishlists < ActiveRecord::Migration[5.1]
  def change
  	add_column :wishlists, :count, :integer, default: 0
  end
end
