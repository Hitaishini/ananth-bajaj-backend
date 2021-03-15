class Gallery < ActiveRecord::Base
	audited
	serialize :image
	belongs_to :bike
end
