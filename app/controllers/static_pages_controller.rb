class StaticPagesController < ApplicationController
    def home
  		@user = current_user
        @idea = current_user.ideas.build if current_user
        if @user
            select_community(@user.communities.first) if @user.communities.count > 0
        else
        end
        @community = current_community if current_user
    end

    def set_community
    	@community = Community.find(params[:community_id])
    	select_community(@community)
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

    def get_branch_page
        if params[:idea]
            @idea = Idea.find(params[:idea])
        elsif params[:vote][:idea_id]
            @idea = Idea.find(params[:vote][:idea_id])
        else
            @idea = BranchIdea.find(params[:vote][:branch_idea_id]).idea
        end
        if branch_idea_sort_style(@idea.id)
            @sorted_branch_ideas = @idea.branches.reorder(branch_idea_sort_style(@idea.id) => :desc).page(params[:page])
        else
            @sorted_branch_ideas = @idea.branches.page(params[:page])
        end
        respond_to do |format|
            format.html { redirect_to root_url }
            format.js
        end
    end
end
