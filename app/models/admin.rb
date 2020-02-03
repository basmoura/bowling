class Admin < ApplicationRecord
  has_many :bowling_houses, dependent: :destroy
  accepts_nested_attributes_for :bowling_houses,
                                allow_destroy: true,
                                reject_if: :all_blank

  has_secure_password
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
