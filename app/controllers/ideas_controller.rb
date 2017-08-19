class IdeasController < ApplicationController
	before_action :community_member, only: [:create]
	
	def create
		@idea = current_user.ideas.build(idea_params)
		if @idea.save
			flash[:success] = "Idea created!"
			redirect_to current_community
		else
			flash[:danger] = "Idea creation failed."
			redirect_to root_url
		end
	end

	def show
		@idea = Idea.find(params[:id])
		@branch_idea = BranchIdea.new
	end

	def sort_branch_ideas
		@idea = Idea.find_by(params[:idea])
		sort_branch_ideas_by(@idea.id, branch_idea_sort_params)
	end

	private

		def idea_params
     		params.require(:idea).permit(:content, :user_id, :community_id)
    	end

    	def branch_idea_sort_params
    		params.require(:branch_sort_style)
    	end

end