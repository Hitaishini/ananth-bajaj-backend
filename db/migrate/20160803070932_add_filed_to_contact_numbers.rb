class AddFiledToContactNumbers < ActiveRecord::Migration[5.1]
  def change
  	add_column :contact_numbers, :contact_type_id, :integer
  	remove_column :contact_types, :type
  	add_column :contact_types, :contact_type, :string
  end
end
