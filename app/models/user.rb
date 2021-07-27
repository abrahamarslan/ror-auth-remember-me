class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :transform_fields
  validates :name, {presence: true, length: {maximum: 50}}
  validates :email, {presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }}
  has_secure_password
  validates :password, length: {minimum: 6}

  protected
  def transform_fields
    self.email.downcase!
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #Returns a random token as a remember-me token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #Remembers a user in the database for use in a persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #Forget a user
  def forget(user)
    update_attribute(:remember_digest, nil)
  end

  #Returns true if the given token matches the digest
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
