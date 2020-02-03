class Lane < ApplicationRecord
  has_many :games, dependent: :destroy
  accepts_nested_attributes_for :games,
                                allow_destroy: true,
                                reject_if: :all_blank
  belongs_to :bowling_house

  enum status: [:open, :maintenance]
end
