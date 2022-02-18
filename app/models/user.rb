# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, 
                   length: { minimum: 1, maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { minimum: 5, maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true,
                       length: { minimum: 6, maximum: 30 },
                       allow_nil: "true" # empty password when signing_up still catches by has_secure_password method

  has_secure_password

  # Returns the hash of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest, once specified
  # the digest type : :activation_digest or :remember_digest
  def authenticated?(type, token)
    digest = send("#{type}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  # Downcase email
  def downcase_email
    email.downcase!
  end

  # Creates and assign an activation token and digest
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
