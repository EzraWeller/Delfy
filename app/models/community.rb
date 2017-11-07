class Community < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships
	has_many :ideas, dependent: :destroy
	has_many :branch_ideas
	has_many :votes
	has_many :invitations
	default_scope -> { order(:name) }
	validates(:name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false })
	validates(:description,  presence: true, length: { maximum: 400 })
	validates(:leader,  presence: true)
	paginates_per 25

	include PgSearch
	pg_search_scope :search_communities_for, against: [:name, :description]
	multisearchable against: [:name, :description]

	def leader?(user)
		leader == user.id
	end

end