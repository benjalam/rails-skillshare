class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_many :reviews
end
