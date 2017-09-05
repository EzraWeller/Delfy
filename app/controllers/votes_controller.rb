class VotesController < ApplicationController
	include VotesHelper
	before_action :three_votes_max,   only: [:create]
	before_action :community_member,  only: [:create, :destroy]

	def create
		@vote = Vote.new(vote_params)
		if @vote.save
			new_root_when_creating
		else
			flash[:danger] = "Only one vote per idea tree."
			redirect_to request.referrer
		end
	end

	def destroy
		@vote = Vote.find_by(vote_params)
		if @vote.destroy
			new_root_when_destroying
		else
			flash[:danger] = "Vote failed to be destroyed."
			redirect_to request.referrer
		end
	end

	private

		def vote_params
			params.require(:vote).permit(:user_id, :community_id, :idea_id, :branch_idea_id, :root)
		end

		def three_votes_max
			unless Vote.where(user_id: current_user.id, community_id: current_community.id).count < 3
				flash[:danger] = "Only three votes per community."
				redirect_to request.referrer
			end
		end
end