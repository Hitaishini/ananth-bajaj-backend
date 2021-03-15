class Website::PasswordsController < ApplicationController
  skip_before_filter :authenticate_user!
  def create
		@user = User.find_by_email(params[:email])
    #@user.reset_password_token =  @user.send_reset_password_instructions

    
    if @user.present?
        @user.send_password_reset 
        @user.save
       head :status => 200
    else
      #render status: 422, json: { errors:  "User doesn't exist" }
        render json: {errors: "User doesn't exist"}, status: 422
    end
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      after_sign_in_path_for(resource) if is_navigational_format?
    end
end