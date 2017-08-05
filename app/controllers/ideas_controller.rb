class IdeasController < ApplicationController
	# before_action :community_member, only: [:create]
	
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

	private

		def idea_params
     		params.require(:idea).permit(:content, :user_id, :community_id)
    	end

end