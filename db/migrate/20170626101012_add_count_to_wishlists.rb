class AddCountToWishlists < ActiveRecord::Migration
  def change
  	add_column :wishlists, :count, :integer, default: 0
  end
end
