class Web::V1::ApiTokensController < ApplicationController
	before_action :authenticate_user!
	respond_to :json

	def create
		@user = User.find_by_id(params[:id])
		@user.reset_authentication_token!
		render json: @user
	end

end