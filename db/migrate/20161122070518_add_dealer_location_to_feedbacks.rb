class AddDealerLocationToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :dealer_location, :string
  	add_column :service_bookings, :address, :string
  end
end
