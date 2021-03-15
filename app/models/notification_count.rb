class NotificationCount < ActiveRecord::Base
	belongs_to :user

	def add_notification_count(template)
		case template
		when 'Bookings'
			self.bookings += 1
			self.count += 1
		when 'Offer'
			self.offer += 1
			self.count += 1
		when 'Accessories'
			self.accessories += 1
			self.count +=1
		when 'Events'
			self.events +=1
			self.count +=1	
		when 'Tips'
			self.tips +=1
			self.count +=1	
		end
		self.save	
		self.reload	
	end

	def reset_count_for_category(action)
		case action
		when 'Bookings'
			if self.bookings > 0 
				c = self.count - 1
				b = self.bookings - 1
				self.update_attribute(:count, c)
				self.update_attribute(:bookings, b)
			end
		when 'Offer'
			if self.offer > 0 
				c = self.count - 1
				b = self.offer - 1
				self.update_attribute(:count, c)
				self.update_attribute(:offer, b)
			end
		when 'Accessories'
			if self.accessories > 0
				c = self.count - 1
				accss = self.accessories - 1
				self.update_attribute(:count, c)
				self.update_attribute(:accessories, accss)
			end
		when 'Events'
			if self.events > 0
				c = self.count - 1
				event = self.events - 1
				self.update_attribute(:count, c)
				self.update_attribute(:events, event)
			end
		when 'Tips'
			if self.tips > 0
				c = self.count - 1
				event = self.tips - 1
				self.update_attribute(:count, c)
				self.update_attribute(:tips, event)
			end
		end
		self.reload
	end	
end
