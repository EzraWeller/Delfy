class MembershipsController < ApplicationController
	before_action :logged_in_user

	def create
		@community = Community.find(params[:community_id])
		current_user.join(@community)
		respond_to do |format|
			format.html { redirect_to @community}
		end
	end

	def destroy
	end

end
