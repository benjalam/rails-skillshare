class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  before_action :set_skill, only: [:new]

  def show
    @review = Review.new
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.skill = Skill.find(params[:skill_id])
    if @booking.save
      redirect_to skill_booking_path(@booking.skill, @booking)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_skill
    @skill = Skill.find(params[:skill_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
