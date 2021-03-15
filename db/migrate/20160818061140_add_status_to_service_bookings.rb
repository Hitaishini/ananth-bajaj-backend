class AddStatusToServiceBookings < ActiveRecord::Migration
  def change
    add_column :service_bookings, :status, :string, default: 'Active'
    change_column :bikes, :start_price, :string
    remove_column :bikes, :end_price
  end
end
