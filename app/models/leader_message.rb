class LeaderMessage < ApplicationRecord
	belongs_to :community
	belongs_to :user

	validates(:content,  presence: true, length: { maximum: 500 })

	paginates_per 25
end
