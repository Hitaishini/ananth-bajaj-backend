class Wishlist < ApplicationRecord
	has_many :accessories, :through => :accessory_wishlist	
	has_many :accessory_wishlist
	belongs_to :user
end
