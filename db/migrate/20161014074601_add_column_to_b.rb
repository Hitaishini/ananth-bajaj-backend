class AddColumnToB < ActiveRecord::Migration[5.1]
  def change
    add_column :bikes, :total_price, :string
  end
end
