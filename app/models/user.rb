class User < ApplicationRecord
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
end
