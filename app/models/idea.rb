class Idea < ApplicationRecord
	belongs_to :user
	belongs_to :community
	has_many   :branches, class_name: "BranchIdea"
	has_many   :votes
	default_scope -> { order(votes_count: :desc) }
	validates  :user_id, presence: true
	validates  :community_id, presence: true
	validates  :content, presence: true, length: { maximum: 140 }
	paginates_per 25

end
