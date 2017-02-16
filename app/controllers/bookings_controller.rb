class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update]
  before_action :set_skill, only: [:create, :show]

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.skill = @skill
    @booking.final_price = (@booking.end_date.split("/")[1].to_i - @booking.start_date.split("/")[1].to_i) * @booking.skill.price
    if @booking.save
      redirect_to skill_booking_path(@skill, @booking)
    else
      render :new
    end
  end

  def update
    @booking.update(booking_params)
    @user = @booking.skill.user
    redirect_to user_path(@user)
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
