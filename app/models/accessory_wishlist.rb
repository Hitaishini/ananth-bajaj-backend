class AccessoryWishlist < ApplicationRecord
	belongs_to :wishlist
	belongs_to :accessory

	#validation
	validates :accessory_id, uniqueness: { scope: :wishlist_id }, presence: true
end
