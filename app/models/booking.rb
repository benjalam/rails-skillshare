STATUS = ["pending", "accepted", "rejected", "canceled"]

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :reviews
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: {in: STATUS, allow_nil: false}

  def available?(booking, form_start_date, form_end_date)
    if form_start_date >= Date.strptime(booking.end_date, '%m/%d/%Y') || form_end_date <= Date.strptime(booking.start_date, '%m/%d/%Y')
      false
    else
      true
    end
  end
end

