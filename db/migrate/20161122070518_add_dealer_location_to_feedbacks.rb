class AddDealerLocationToFeedbacks < ActiveRecord::Migration[5.1]
  def change
  	add_column :feedbacks, :dealer_location, :string
  	add_column :service_bookings, :address, :string
  end
end
