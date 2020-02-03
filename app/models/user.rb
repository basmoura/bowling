class User < ApplicationRecord
  validates :name, :nickname, presence: true
  validates :nickname, uniqueness: true
end
