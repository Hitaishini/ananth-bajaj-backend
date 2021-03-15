class AccessoryTag < ActiveRecord::Base
	belongs_to :accessory
	belongs_to :tag
end
