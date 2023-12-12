class User < ApplicationRecord
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.where('LOWER(email) = ?', email.strip.downcase).first
    user&.authenticate(password) ? user : nil
  end
end
