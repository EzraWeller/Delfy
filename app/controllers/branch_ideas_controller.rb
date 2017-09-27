class BranchIdeasController < ApplicationController
	before_action :community_member, only: [:create]
	before_action :admin_user,       only: [:destroy]

	def create
		@branch_idea = current_user.branch_ideas.build(branch_idea_params)
		if @branch_idea.save
			flash[:success] = "Branch idea created!"
			redirect_to request.referrer
		else
			flash[:danger] = "Branch idea creation failed."
			redirect_to request.referrer
		end
	end

	def destroy
		@branch_idea = BranchIdea.find(params[:id])
		@branch_idea.destroy
		flash[:success] = "Branch idea deleted."
		redirect_to request.referrer
	end

	private

		def branch_idea_params
			params.require(:branch_idea).permit(:content, :user_id, :community_id, :idea_id)
		end

end
