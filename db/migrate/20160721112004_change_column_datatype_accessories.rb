class ChangeColumnDatatypeAccessories < ActiveRecord::Migration[5.1]
  def change
  	change_column :accessories, :size, :string
  end
end
