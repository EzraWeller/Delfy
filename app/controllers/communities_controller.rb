class CommunitiesController < ApplicationController
	

	def show
    	@community = Community.find(params[:id])
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

	private
  
		def community_params
    		params.require(:community).permit(:name, :description, :leader)
		end

end
