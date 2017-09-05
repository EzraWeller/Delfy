class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :community
	belongs_to :idea
	belongs_to :branch_idea, optional: true
	belongs_to :temp_box,    optional: true

	before_create :one_vote_per_idea

	after_save    :update_votes_count
	after_destroy :update_votes_count

	private

		def one_vote_per_idea
			unless Vote.where(user: self.user, idea: self.idea).count < 1
				throw :abort
			end
		end


		def update_votes_count
			if self.root == true
				self.idea.update_attribute(:votes_count, self.idea.votes.count)
			elsif self.branch_idea
				self.branch_idea.update_attribute(:votes_count, self.branch_idea.votes.count)
			else
			end
		end
end