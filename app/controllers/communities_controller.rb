class CommunitiesController < ApplicationController
	before_action :logged_in_user, only: [:create, :new, :show]

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

	def index
    	@communities = Community.all
	end

	def sort_ideas
		sort_ideas_by(idea_sort_params)
	end

	private
  
		def community_params
    		params.require(:community).permit(:name, :description, :leader)
		end

		def idea_sort_params
			params.require(:sort_style)
		end

end