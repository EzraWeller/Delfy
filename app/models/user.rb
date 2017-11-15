class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :memberships
  has_many :communities, through: :memberships
  has_many :ideas
  has_many :branch_ideas
  has_many :votes, dependent: :destroy
  has_many :invitations
  has_many :leader_messages
  validates(:name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true})
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 255 }, 
             format: { with: VALID_EMAIL_REGEX }, 
             uniqueness: { case_sensitive: false})
  has_secure_password

  before_save   :downcase_email
  before_create :create_activation_digest

  include PgSearch
  pg_search_scope :search_users_for, against: [:name, :email]
  multisearchable against: [:name, :email]

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
    memberships.find_by(community_id: community.id).destroy
  end

  # Returns true if the user is a member of the community.
  def member_of?(community)
    communities.include?(community)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Sends community invitation email.
  def invite(invitation)
    UserMailer.community_invitation(invitation).deliver_now
  end

  # Sends removal reason email.
  def send_removal(membership)
    UserMailer.remove_membership(membership).deliver_now
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_new_activation_digest
    activation_token  = User.new_token
    activation_digest = User.digest(activation_token)
    self.activation_token = activation_token
    self.update_attribute(:activation_digest, activation_digest)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
