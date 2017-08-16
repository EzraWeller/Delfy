class User < ApplicationRecord
  has_many :memberships
  has_many :communities, through: :memberships
  has_many :ideas
  has_many :branch_ideas
  has_many :votes
  validates(:name,  presence: true, length: { maximum: 50 })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 255 }, 
             format: { with: VALID_EMAIL_REGEX }, 
             uniqueness: { case_sensitive: false})
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Joins a community.
  def join(community)
    communities << community
  end

  # Leaves a community.
  def leave(community)
    communities.delete(community)
  end

  # Returns true if the user is a member of the community.
  def member_of?(community)
    communities.include?(community)
  end

end
