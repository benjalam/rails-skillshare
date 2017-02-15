class Skill < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  validates :title, presence: true
  validates :description, presence: true
  validates :city, presence: true
  mount_uploader :photo, PhotoUploader

  def self.search(params)
   where("title ILIKE ?", "%#{params[:search]}%")
  end

  def available?(skill, form_start_date, form_end_date)
    skill.bookings.each do |booking|
      if booking.available?(booking, form_start_date, form_end_date)
        return true
      else
        return false
      end
    end
  end
end
