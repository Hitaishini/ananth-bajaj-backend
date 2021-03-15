class Web::V1::PasswordsController < ApplicationController
  
  def create
		@user = User.find_by_email(params[:email])
    @user.reset_password_token =  @user.send_reset_password_instructions
    @user.save
    if @user
       head :status => 200
    else
      render :status => 422, :json => { :errors => @user.errors.full_messages }
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
