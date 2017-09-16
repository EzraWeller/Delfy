class Membership < ApplicationRecord
	attr_accessor :access_token
	belongs_to :user
	belongs_to :community
	validates :user_id,      presence: true
	validates :community_id, presence: true
end