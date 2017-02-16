class Skill < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  validates :title, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :price, presence: true
  mount_uploader :photo, PhotoUploader

  geocoded_by :city
  after_validation :geocode, if: :city_changed?


  def self.search(params)
   where("title ILIKE ?", "%#{params[:search]}%")
  end

  def available?(skill, form_start_date, form_end_date)
    skill.bookings.each do |booking|
      if booking.available?(booking, form_start_date, form_end_date)
        return true
      end
    end
    return false
  end
end
