class Gallery < ApplicationRecord
	audited
	serialize :image
	belongs_to :bike
end
