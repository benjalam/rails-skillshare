class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
   @review = Review.new(review_params)
   @booking = Booking.find(params[:booking_id])
   @review.booking = @booking
   @review.save
   redirect_to booking_path(@booking)
   # il faut nester review dans booking
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
   params.require(:review).permit(:title, :description, :rating)
 end

end

