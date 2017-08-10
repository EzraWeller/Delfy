class Idea < ApplicationRecord
	belongs_to :user
	belongs_to :community
	has_many   :votes
	default_scope -> { order(created_at: :desc) }
	validates  :user_id, presence: true
	validates  :community_id, presence: true
	validates  :content, presence: true, length: { maximum: 140 }
end
