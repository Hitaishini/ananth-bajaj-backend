class AddDisplayOrderBikesTypes < ActiveRecord::Migration
  def change
  	add_column :bike_types, :display_order, :integer
  end
end
