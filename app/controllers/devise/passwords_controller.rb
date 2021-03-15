class Devise::PasswordsController < ActionController::Base
  def edit
	 	@token = params[:format]
    puts "============================================================="
    logger.info "====================#{params.inspect}"
  	@user = User.find_by_reset_password_token(@token)
    #@user = User.find(params[:format])
    logger.info "==========#{@user.inspect}======anil======"
    if @user.present?
	   	render 'passwords/reset_password.html.erb'
    else
      render 'passwords/error.html.erb'
    end
  end

  def update_password
        @user = User.find_by_id(params[:user])

        if params[:password] != params[:password_confirmation]
           redirect_to :back, :notice => "Passwords Doesn't match"
        elsif @user.update(password: params[:password])
            reset_auth_token
           render 'passwords/success.html.erb'
        else
            redirect_to :back, :alert => "Something went worng! Please try again."
        end
    
  end	

  private

  def reset_auth_token
  	@user.reset_authentication_token!
    @user.save
  end
  	
	def user_params
		params.require(:user).permit(:password, :password_confirmation)
	end
end  	