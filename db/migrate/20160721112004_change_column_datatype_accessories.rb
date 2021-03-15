class ChangeColumnDatatypeAccessories < ActiveRecord::Migration
  def change
  	change_column :accessories, :size, :string
  end
end
