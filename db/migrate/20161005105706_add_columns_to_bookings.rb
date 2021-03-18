class AddColumnsToBookings < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_bookings, :name, :string
  	add_column :service_bookings, :email, :string
  	add_column :service_bookings, :mobile, :string
  end
end
