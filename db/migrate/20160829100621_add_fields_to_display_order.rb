class AddFieldsToDisplayOrder < ActiveRecord::Migration
  def change
  	add_column :dealer_contact_numbers, :display_order, :integer
  end
end
