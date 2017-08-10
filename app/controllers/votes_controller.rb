class VotesController < ApplicationController
	before_action :three_votes_max, only: [:create]

	def create
		@vote = Vote.new(vote_params)
		if @vote.save
			flash.now[:success] = "Vote recorded."
		else
			flash.now[:danger] = "Vote not recorded."
		end
	end

	def destroy
		@vote = Vote.find_by(vote_params)
		@vote.delete
	end

	private

		def vote_params
			params.require(:vote).permit(:user_id, :community_id, :idea_id)
		end

		def three_votes_max
			unless Vote.where(user_id: current_user.id, community_id: current_community.id).count < 3
				flash[:danger] = "Only three votes per community."
				redirect_to root_url
			end
		end

end