class Membership < ApplicationRecord
	attr_accessor :access_token
	belongs_to :user
	belongs_to :community
	validates :user_id,      presence: true
	validates :community_id, presence: true
	validates :removal_reason, length: { maximum: 400 }

	# Prevents true deletion unless "really_destroy!"-ed
	acts_as_paranoid
end