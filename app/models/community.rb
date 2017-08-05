class Community < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships
	has_many :ideas
	validates(:name,  presence: true, length: { maximum: 100 })
	validates(:description,  presence: true, length: { maximum: 400 })
	validates(:leader,  presence: true)
end