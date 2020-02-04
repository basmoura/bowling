class Game < ApplicationRecord
  has_many :frames
  has_many :users, through: :frames
  belongs_to :lane

  validates :start_at, presence: true
  validates :end_at, presence: true, on: :update, if: :ended?

  enum status: [:live, :ended]
end
