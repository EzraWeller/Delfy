class Invitation < ApplicationRecord
	attr_accessor :access_token
	belongs_to :community
	belongs_to :user
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, presence: true, length: { maximum: 255 }, 
               format: { with: VALID_EMAIL_REGEX } )
	validates :community_id, presence: true
	validates :user_id, presence: true

	before_create :create_access_digest, :community_leader

	# Returns a random token.
 	def Invitation.new_token
      SecureRandom.urlsafe_base64
	end

	# Returns the hash digest of the given string.
    def Invitation.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns true if the invitation has been accepted.
 	def accepted?
 		accepted == true
 	end

    # Returns true if the given token matches the digest.
	def authenticated?(token)
      digest = self.access_digest
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token) && !self.accepted?
 	end

 	private

		def create_access_digest
	      self.access_token  = Invitation.new_token
	      self.access_digest = Invitation.digest(access_token)
	    end

	    def community_leader
	    	self.community.leader == self.user
	    end

end
