class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email

  validates :first_name, :last_name, presence: true
  validates :email, presence: true
  validates :password, confirmation: {case_sensitive: true}, length: {minimum: 6}
end