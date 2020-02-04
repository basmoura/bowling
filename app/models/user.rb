class User < ApplicationRecord
  has_many :frames
  has_many :games, through: :frames

  validates :name, :nickname, presence: true
  validates :nickname, uniqueness: true

  def last_ended_frame
    frames.where(status: 'ended').last
  end
end
