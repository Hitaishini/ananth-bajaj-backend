class Website::UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update, :show, :destroy, :update_wishlist_items, :remove_wishlist_items, :get_wishlist_items, :wishlist_count]
	respond_to :json
	# before_action :set_user, only: [:show, :update, :destroy]

	def create
		@user = User.new(user_params)

		if params[:user][:social_login] == 1 
			user_email = params[:user][:email]
			user = User.find_by_email(user_email)
			if user_email.present? && user.present?
				logger.info "=======No facebook user==========="
				sign_in user, store: false
				user.update_device_token_with_social(params)
				user.save
				token = Tiddle.create_and_return_token(user, request)
				render json: user, status: 200, serializer: Website::V1::UserSerializer, token: token
			else
				#template = NotificationTemplate.where(category: I18n.t('Notification.welcome')).last
				logger.info "============facebook user=========="
				logger.info "=======params[:user]=========="
				facebook_user = User.find_by_facebook_id(params[:user][:facebook_id]) if params[:user][:facebook_id].present?
				
				if facebook_user.present?
					logger.info "======#{facebook_user.inspect}======="
					count = facebook_user.sign_in_count + 1
					facebook_user.update(sign_in_count: count)
					sign_in facebook_user, store: false
					facebook_user.update_device_token_with_social(params)
					token = Tiddle.create_and_return_token(facebook_user, request)
					render json: facebook_user, status: 200, serializer: Website::V1::UserSerializer, token: token
				else
					logger.info "==========validation failed==========="
					if @user.save(validate: false)
						logger.info "==========user saves======#{@user.inspect}========="
						users_creation(params)
						token = Tiddle.create_and_return_token(@user, request)
						users_social_login(params)
						render json: @user, status: 201, serializer: Website::V1::UserSerializer, token: token
					else
						logger.info "==========user errors======#{@user.errors.inspect}========="
						render json: { errors: @user.errors}, status: 422
					end
					#@user.send_welcome_notification(template, params)
				end
				#@user.send_welcome_notification(template)
			end
		elsif @user.save
			logger.info "=======No social login==========="
			token = Tiddle.create_and_return_token(@user, request)
			render json: @user, status: 201, serializer: Website::V1::UserSerializer, token: token
			users_creation(params)
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def users_creation(params)
		template = NotificationTemplate.where(category: I18n.t('Notification.welcome')).last
		mobile = params[:user][:mobile]
		name = params[:user][:name]
		Profile.create( user_id: @user.id, email: @user.email, full_name: name, mobile: mobile)
		#HogRegistration.create( user_id: @user.id, email: @user.email, full_name:name, mobile: mobile)
		NotificationCount.create(user_id: @user.id)
		#unless params[:user][:facebook_id]
		@user.delay.send_welcome_notification(template)
		#end
		#UserMailer.welcome_user(@user).deliver
		#render json: @user, status: 201, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
	end

	def users_social_login(params)
		user_email = params[:user][:email] || ""
		user = User.find_by_email(user_email)
		if user.present?
			if params[:user][:social_login] == 1
				sign_in user, store: false
				user.update_device_token_with_social(params)
				user.save
			else
				render json: { errors: "Invalid Registration" }, status: 422
			end
		else
			render json: {message: "Invalid Registration"}, status: 422
		end
	end 

	def show
		respond_with User.find(params[:id]), serializer: Website::V1::UserSerializer
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			render json: @user, status: 200, serializer: Website::V1::UserSerializer
		else
			render json: { errors: @user.errors }, status: 422
		end
	end
	#for user wishlist count
	def wishlist_count
		@count = current_user.wishlist if current_user
		@count.reload
		render json: @count
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		message = "Your account has been successfully deleted"
		render json: { message: message}, status: 204
	end

	def update_wishlist_items
		accessories = params[:accessory_ids]
		wishlist_id = current_user.wishlist.try(:id)
		count = current_user.wishlist.count
		accessories.each do |accessory|
			@acc_wish = AccessoryWishlist.new(accessory_id: accessory, wishlist_id: wishlist_id)
			if @acc_wish.save
				count += 1
				current_user.wishlist.update(count: count)
			end
		end
	end

	def get_wishlist_items
		@accessories = current_user.wishlist.accessories
		render json: @accessories
	end

	def remove_wishlist_items
		@accessory = params[:accessory_ids]
		count = current_user.wishlist.count
		@accessory.each  do |accessory_id|
			AccessoryWishlist.where(wishlist_id: current_user.wishlist.id).find_by_accessory_id(accessory_id).delete
			count -= 1
			current_user.wishlist.update(count: count)
	end
	#message = "Removed From Wishlist"
	@remaining_accessories = current_user.wishlist.accessories
	 render json: @remaining_accessories #,each_serializer: Website::V1::User::RemoveWishlistItemsSerializer
	end

	def notification_count
		@count = current_user.notification_count
		logger.info "=====================#{@count.inspect}=========="
		@count.reload if @count
		render json: @count
	end

	def notification_by_category
		@notifications = current_user.notifications.where(action: params[:category]).order("updated_at DESC").order("created_at DESC") 
		render json: @notifications, each_serializer: Website::V1::NotificationSerializer
	end	

	def update_password
		user_password = params[:old_password]
		if current_user.valid_password? user_password
			current_user.update(password: params[:new_password]) 
			render json: { message: I18n.t('General.password_update.successful')}, status: 200
		else
			render json: { message: I18n.t('General.password_update.unsuccessful')}, status: 400
		end	
	end	


	def clear_notification_count
		if current_user.notification_count.present?
			@count = current_user.notification_count.reset_count_for_category(params[:category])
			message = "Your notification has been successfully cleared"
		else
			message = "Your didnot have any notifications"
		end
		render json: { message: message}, status: 204
	end	

	#for payment changes
	def user_due_payments
		user = User.find_by_id(params[:user_id])
		@payments = user.payments.where(status: ['Created']).order("updated_at DESC").order("created_at DESC")  

		render json: @payments
	end

	def user_due_payments_by_user_id
		@user = User.find_by_id(params[:user_id])
		@payments = @user.payments.where(status: ['Created']).order("updated_at DESC").order("created_at DESC")   
		render json: @payments
	end	

	def user_completed_payments
		@user = User.find_by_id(params[:user_id])
		@payments = @user.payments.where(status: ['failure','success']).order("updated_at DESC").order("created_at DESC")   
		render json: @payments, each_serializer: Website::V1::PaymentHistorySerializer 
	end	


	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :android_token, :ios_token, :social_login ,:facebook_id)
	end

end