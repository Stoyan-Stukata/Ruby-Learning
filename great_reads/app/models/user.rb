class User < ApplicationRecord
  has_many :books

  validates :email, uniqueness: true
  validates :username, uniqueness: { case_sensitive: false }

  before_save :encrypt_password

  private
    def encrypt_password
      self.password = BCrypt::Password.create(self.password)
    end
end
