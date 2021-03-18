class AddRegistrationNumberToVas < ActiveRecord::Migration[5.1]
  def change
  	add_column :value_added_services, :registration_number, :string
  end
end
