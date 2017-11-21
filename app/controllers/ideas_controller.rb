class IdeasController < ApplicationController
	before_action :community_member,   only: [:create]
	before_action :user_owns_or_admin, only: [:destroy]
	
	def create
		@idea = current_user.ideas.build(idea_params)
		if @idea.save
			flash[:success] = "Idea created!"
			redirect_to request.referrer
		else
			flash[:danger] = "Idea creation failed."
			redirect_to request.referrer
		end
	end

	def show
		@idea = Idea.find(params[:id])
		@branch_idea = BranchIdea.new
	end

	def sort_branch_ideas
		@idea = Idea.find_by(id: params[:idea])
		sort_branch_ideas_by(@idea.id, branch_idea_sort_params)
	end

	def search
		@ideas = Idea.search_content_for(params[:search]).where(community_id: params[:community_id])
			@searchedbranches = BranchIdea.search_content_for('lorem').where(community_id: params[:community_id]).pluck(:id)
			@branchesideas = Idea.where(id: BranchIdea.where(id: @searchedbranches).pluck(:idea_id)).distinct
		@ideas_w_branches = @branchesideas - @ideas
		@branches = BranchIdea.search_content_for(params[:search])
	end

	def destroy
		@idea = Idea.find(params[:id])
		@idea.destroy
		flash[:success] = "Idea deleted."
		redirect_to request.referrer
	end

	private

		def idea_params
     		params.require(:idea).permit(:content, :user_id, :community_id)
    	end

    	def branch_idea_sort_params
    		params.require(:branch_sort_style)
    	end

    	def user_owns_or_admin
    		@idea = Idea.find(params[:id])
    		current_user == @idea.user && @idea.votes.where.not(user: current_user).count == 0 || current_user.admin == true
    	end

end