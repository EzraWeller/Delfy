class MembershipsController < ApplicationController
	before_action :logged_in_user

	def create
		@community = Community.find(params[:community_id])
		current_user.join(@community)
		respond_to do |format|
			format.html { redirect_to @community }
			format.js
		end
	end

	def destroy
		@community = Membership.find(params[:id]).community
		current_user.leave(@community)
		respond_to do |format|
			format.html { redirect_to @community }
			format.js
		end
	end

end
