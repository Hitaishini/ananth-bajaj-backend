class Web::V1::AccessoryEnquiriesController < ApplicationController

	def index
		@accessory_enq = AccessoryEnquiry.all.order("updated_at DESC").order("created_at DESC")
		render json: @accessory_enq
	end	

	def show
		@accessory_enq = AccessoryEnquiry.find(params[:id])
		render json: @accessory_enq
	end


	def destroy
		@accessory_enq = AccessoryEnquiry.find params[:id]
		@accessory_enq.destroy

		head :no_content 
	end	

	def delete_accessory_enquiries
		@accs = params[:accessory_enquiry_ids]
		@accs.each do |acc|
			AccessoryEnquiry.find(acc).destroy
		end
		head :no_content 
	end

	# def wishlist_delete
	# 	@wishlist = Wishlist.find(params[:id])
	# 	@wishlist.destroy

	# 	head :no_content 
	# end	

	def delete_wishlists
		@acc_enquiry = params[:wishlist_ids]
		@acc_enquiry.each do |acc|
			AccessoryEnquiry.find(acc).destroy
		end
		head :no_content 
	end



end