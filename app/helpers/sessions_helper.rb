module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def select_community(community)
		session[:community_id] = community.id
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def current_community
		@current_community ||= Community.find_by(id: session[:community_id])
	end

	def logged_in?
		!current_user.nil?
	end

    def user_community_member?
    	!current_community.users.include?(current_user)
    end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	# Redirects to stored location (or to the default).
	def redirect_back_or(default)
    	redirect_to(session[:forwarding_url] || default)
   		session.delete(:forwarding_url)
  	end

	# Stores the URL trying to be accessed.
  	def store_location
    	session[:forwarding_url] = request.original_url if request.get?
  	end

end
