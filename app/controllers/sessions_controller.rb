class SessionsController < ApplicationController
  
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  		if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        select_community(@user.communities.first) if @user.communities.exists?
  		  redirect_back_or root_url
      else
        @user.create_new_activation_digest
        @user.send_activation_email
        message = "Account not activated."
        message += " A new activation email is being sent: check your email for the most recent activation link in a few minutes."
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Logged out."
    redirect_to root_url
  end
  
end