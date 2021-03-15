class Web::V1::SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:destroy]
	def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]    
    user = user_email.present? && User.find_by(email: user_email)
    if user.present?
      if user.valid_password? user_password
        sign_in user, store: false
        user.reset_authentication_token!
        user.save
        render json: user, status: 200, location: [:web, user] 
      else
        render json: { errors: "Invalid email or password" }, status: 422
      end
    else
      render json: {errors: "Invalid Registration"}, status: 422
    end
  end

  def destroy
    user = User.find_by(authentication_token: params[:auth_token])
    user.reset_authentication_token!
    user.save
    message = "You have been successfully signed out"
    render json: user, status: 204, location: [:web, user]
  end

end