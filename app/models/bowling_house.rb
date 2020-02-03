class BowlingHouse < ApplicationRecord
  has_many :lanes, dependent: :destroy
  accepts_nested_attributes_for :lanes,
                                allow_destroy: true,
                                reject_if: :all_blank
  belongs_to :admin
  validates :name, presence: true
end
