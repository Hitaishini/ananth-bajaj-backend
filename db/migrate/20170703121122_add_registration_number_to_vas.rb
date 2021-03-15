class AddRegistrationNumberToVas < ActiveRecord::Migration
  def change
  	add_column :value_added_services, :registration_number, :string
  end
end
