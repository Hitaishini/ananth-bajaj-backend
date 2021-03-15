class Web::V1::UsersController < ApplicationController
	# before_filter :authenticate_user!
	respond_to :json

	def index
		limit, offset = Calculator.limit_and_offset(params)
		@users = User.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

		render json: @users.includes(:profile), status: 200, each_serializer: Web::V1::UserSerializer
	end

	def create
		@user = User.new(user_params)
		if @user.save
			audit(@user, current_user)
			mobile = params[:user][:mobile] || 0
			name = params[:user][:name] || "N/A"
			Profile.create( user_id: @user.id, email: @user.email, full_name: name, mobile: mobile)
			HogRegistration.create( user_id: @user.id, email: @user.email, full_name:name, mobile: mobile) if @user.role == "guest"
			NotificationCount.create(user_id: @user.id)
			Notification.create(recipient: @user, actor: current_user, action: I18n.t('Notification.welcome'), notifiable: @user)			
			render json: @user, status: 201, location: [:web, @user], serializer: Web::V1::UserSerializer
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def show
		respond_with User.find(params[:id]), serializer: Web::V1::UserSerializer
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			audit(@user, current_user)
			render json: @user, status: 200, location: [:web, @user], serializer: Web::V1::UserSerializer
		else
			render json: { errors: @user.errors }, status: 422
		end
	end

	def destroy
		@user  = User.find(params[:id])
		audit(@user, current_user)
		@user.destroy
		
		message = "Your account has been successfully deleted"
		render json: { message: message}, status: 204
	end

	def delete_users
		@users = params[:user_ids]
		@users.each do |user|
			User.find(user).delete
		end
	end

	def get_my_bikes
		@my_bikes = MyBike.where(user_id: params[:user_id])
		render json: @my_bikes
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :role)
	end

end