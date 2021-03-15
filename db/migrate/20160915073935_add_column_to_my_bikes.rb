class AddColumnToMyBikes < ActiveRecord::Migration
  def change
  	add_column :my_bikes, :status, :string, default: 'Active'
  end
end
