class Lane < ApplicationRecord
  belongs_to :bowling_house

  enum status: [:open, :maintenance]
end
