class Frame < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :first_pins_dropped, presence: true

  before_save :set_points, if: -> { !strike? && !spare? }
  before_create :set_strike, if: -> { first_pins_dropped == 10 }
  before_update :strike_points, if: -> { strike? }

  enum status: [:live, :ended]

  private

  def set_points
    if user.last_ended_frame.present? && user.last_ended_frame.strike?
      if second_pins_dropped.blank?
        self.points = user.last_ended_frame.points + (first_pins_dropped + 10)
      else
        self.points += second_pins_dropped + 10
        self.status = 'ended'
      end
    else
      if second_pins_dropped.blank?
        self.points = first_pins_dropped
      else
        self.points += second_pins_dropped
        self.status = 'ended'
      end
    end
  end

  def set_strike
    self.strike = true
    self.status = 'ended'
    self.points = 10 + (user.last_ended_frame.try(:points) || 0)
  end

  def strike_points
    self.status = 'ended'

    if user.frames.where(status: 'ended').count <= 9
      self.points = points + second_pins_dropped + 10
    else
      self.points = points + third_pins_dropped + 10
    end
  end
end
