STATUS = ["pending", "accepted", "rejected", "canceled"]

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :reviews
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: {in: STATUS, allow_nil: false}
end
