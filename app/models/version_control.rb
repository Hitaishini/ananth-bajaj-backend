class VersionControl < ActiveRecord::Base
	belongs_to :user

	 def user_email
		self.user.try(:email) if self.user 
	end

	def as_json(options={})
		super.as_json(options).merge({:user_email => user_email})
	end
end
