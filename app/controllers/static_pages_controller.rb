class StaticPagesController < ApplicationController
    def home
  		@user = current_user
        @idea = current_user.ideas.build if current_user
        @community = current_community if current_user
    end

    def set_community
    	@community = Community.find(params[:community_id])
    	select_community(@community)
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end

    def show_branch_feed
        @idea = Idea.find(params[:idea])
        respond_to do |format|
            format.html { redirect_to root_url }
            format.js
        end
    end

    def hide_branch_feed
        @idea = Idea.find(params[:idea])
        respond_to do |format|
            format.html { redirect_to root_url }
            format.js
        end
    end
end
