class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  	def logged_in_user
    	unless logged_in?
    		store_location
        flash[:danger] = "Please log in."
      	redirect_to login_url
    	end
  	end

    def community_member
      unless user_community_member?
        flash[:danger] = "Please join community."
        redirect_to request.referrer
      end
    end

    def admin_user
      unless current_user.admin
        flash[:danger] = "Admin only."
        redirect_to request.referrer
      end
    end

end
