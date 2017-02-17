class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_booking, only: [:new, :create, :show, :edit, :update]
  before_action :set_skill, only: [:new, :create, :show, :edit, :update]
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    @booking.skill = @skill
    @review.nature = "skillman"
    if @review.save
      redirect_to skill_booking_path(@skill, @booking)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @review.update(review_params)
       redirect_to skill_booking_review_path(@skill, @booking, @review)
    else
      render :edit
    end
  end

   def destroy
    @booking = @review.booking
    @skill = @review.booking.skill
    @review.destroy
    redirect_to skill_booking_path(@skill, @booking)
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
  def set_skill
    @skill = Skill.find(params[:skill_id])
  end
end

