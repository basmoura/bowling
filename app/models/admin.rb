class Admin < ApplicationRecord
  has_secure_password
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
