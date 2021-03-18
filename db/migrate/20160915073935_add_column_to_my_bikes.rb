class AddColumnToMyBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :my_bikes, :status, :string, default: 'Active'
  end
end
