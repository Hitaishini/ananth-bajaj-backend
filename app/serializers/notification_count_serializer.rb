class NotificationCountSerializer < ActiveModel::Serializer
  attributes :id

  def attributes
  	data = super
  	n_c = NotificationCount.find data[:id]
  	data[:Offer] = n_c.offer || data[:offer]
  	data[:Bookings] = n_c.bookings || data[:bookings]
  	data[:Events] = n_c.events || data[:events]
  	data[:Accessories] = n_c.accessories ||data[:accessories]
    data[:Tips] = n_c.tips || data[:tips]
  	data
  end	
end
