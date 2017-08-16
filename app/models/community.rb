class Community < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships
	has_many :ideas
	has_many :branch_ideas
	has_many :votes
	default_scope -> { order(:name) }
	validates(:name,  presence: true, length: { maximum: 100 })
	validates(:description,  presence: true, length: { maximum: 400 })
	validates(:leader,  presence: true)
end