class Review < ApplicationRecord
  belongs_to :booking
  validates :title, presence: true
  validates :description, presence: true
  validates :rating, presence: true
  validates :nature, inclusion: { in: ["skillman","client"], allow_nil: false }
end
