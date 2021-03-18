class AddSomeFieldChangesBikes < ActiveRecord::Migration[5.1]
  def change
    remove_column :bikes, :start_price
    remove_column :bikes, :bike_cc
  	add_column :bikes, :bike_price, :integer
  	add_column :bikes, :bike_cc, :integer

  end
end
