class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :community
	belongs_to :idea, counter_cache: true
	belongs_to :branch_idea, counter_cache: true, optional: true
	belongs_to :temp_box,    optional: true

	before_create :one_vote_per_idea

	private

		def one_vote_per_idea
			unless Vote.where(user: self.user, idea: self.idea).count < 1
				throw :abort
			end
		end
end