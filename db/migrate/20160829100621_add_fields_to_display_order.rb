class AddFieldsToDisplayOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :dealer_contact_numbers, :display_order, :integer
  end
end
