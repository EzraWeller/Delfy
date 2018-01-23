class StaticPagesController < ApplicationController
    # before_action :select_joined, only: [:home]

    def home
  		@user = current_user
        if current_user
            @idea = current_user.ideas.build
            @community = current_community
            @first_communities = [current_user.communities.first, current_user.communities.second, 
                                  current_user.communities.third] - [nil]
            if @first_communities.include?(@community)
                @menu_communities = [current_user.communities.first, current_user.communities.second, 
                                     current_user.communities.third] - [nil]
                @dropdown_communities = current_user.communities - @menu_communities
            else
                @menu_communities = [current_user.communities.first, current_user.communities.second, 
                                     @community] - [nil]
                @dropdown_communities = current_user.communities - @menu_communities
            end
        end
    end

    def home_w_select
        if current_user
            select_community(current_user.communities.first) unless user_community_member?
        end
        redirect_to home_path
    end

    def about
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

    def new_activation_email
    end

    def send_activation_email
        @email = params[:email]
        @user = User.find_by(email: @email)
        if @user == nil
            flash[:warning] = "No user on record with that email. No activation email sent."
        elsif @user.activated == true
            flash[:warning] = "The account with that email has already been activated."
        else
            @user.create_new_activation_digest
            @user.send_activation_email
            message = "A new activation email is being sent: 
                       check your email for the most recent activation link in a few minutes."
            flash[:success] = message
        end
        redirect_to root_url
    end

    private

        def select_joined
            select_community(current_user.communities.first)
        end

end
