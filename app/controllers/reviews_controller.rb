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
  if @review.save
    redirect_to booking_path(@booking)
  else
    render :new
  end
   # il faut nester review dans booking
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(param[:id])
  end

  def update
    @review = Review.find(param[:id])
    if @review.update(review_params)
       redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

   def destroy
    @review = Review.find(params[:id])
    @booking = @review.booking
    @review.destroy
    redirect_to booking_path(@booking)
  end

  private

  def review_params
   params.require(:review).permit(:title, :description, :rating)
 end

end

