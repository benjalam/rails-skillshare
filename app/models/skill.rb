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
end
