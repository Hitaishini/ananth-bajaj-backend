class AddColumnToB < ActiveRecord::Migration
  def change
    add_column :bikes, :total_price, :string
  end
end
