class AccessoryWishlist < ActiveRecord::Base
	belongs_to :wishlist
	belongs_to :accessory

	#validation
	validates :accessory_id, uniqueness: { scope: :wishlist_id }, presence: true
end
