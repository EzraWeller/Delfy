class CommunitiesController < ApplicationController
	before_action :logged_in_user,  only: [:create, :new, :admin]
	before_action :leader,          only: [:admin]
	before_action :leader_or_admin, only: [:destroy, :update]

	def show
    	@community = Community.find(params[:id])
    	select_community(@community)
      	@idea = current_user.ideas.build
      	@branch_idea = current_user.branch_ideas.build
    end
	
	def new
		@community = Community.new
	end

	def create
		@community = Community.new(community_params)
		if @community.save
			current_user.join(@community)
			flash[:success] = "New community, #{@community.name}, created!"
    		redirect_to @community
		else
			render 'new'
		end
	end

	def update
		@community = Community.find(params[:id])
		if @community.update_attributes(community_params)
	      flash[:success] = "Community settings saved!"
	      redirect_to community_admin_path(@community)
	    else
	      flash[:danger] = "Community settings failed to update."
	      redirect_to community_admin_path(@community)
	    end
	end

	def index
    	@communities = Community.all.page(params[:page])
	end

	def sort_ideas
		sort_ideas_by(idea_sort_params)
	end

	def admin
		@community = Community.find(params[:id])
		@invitation = Invitation.new
		@users = @community.users.page(params[:page])
		@invitations = @community.invitations.reorder(:email).page(params[:page])
		if @community.leader_messages == true
			@past_messages = @community.leader_messages.where.not(id: @community.leader_messages.last.id).page(params[:page])
		end
	end

	def user_list
		@community = Community.find(params[:id])
		@users = @community.users.page(params[:page])
	end

	def destroy
		@community = Community.find(params[:id])
		@community.destroy
		flash[:success] = "Community deleted."
		redirect_back_or(root_url)
	end

	def search
		@communities = Community.search_communities_for(params[:search]).page(params[:page])
	end

	private
  
		def community_params
    		params.require(:community).permit(:name, :description, :leader, :membership_setting)
		end

		def idea_sort_params
			params.require(:sort_style)
		end

		def leader
			@community = Community.find(params[:id])
			if @community.leader?(current_user)

			else
				redirect_to community_path(@community)
				flash[:danger] = "Only community leaders can access admin options."
			end
		end

		def leader_or_admin
    		@community = Community.find(params[:id])
    		@community.leader?(current_user) && @community.users.where.not(id: current_user.id).count == 0 || current_user.admin == true
    	end

end