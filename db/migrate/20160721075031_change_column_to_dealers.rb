class ChangeColumnToDealers < ActiveRecord::Migration
  def change
  	remove_column :dealers, :dealer_type_id
  	add_column :dealers, :dealer_type_id, :text 
  end
end
