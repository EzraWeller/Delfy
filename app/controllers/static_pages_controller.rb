class StaticPagesController < ApplicationController
    def home
  		@user = current_user
    end

    def set_community
    	@community = Community.find(params[:community_id])
    	select_community(@community)
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end
end
