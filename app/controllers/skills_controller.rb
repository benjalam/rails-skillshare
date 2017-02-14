class SkillsController < ApplicationController
  before_action :set_skill, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def index
    @skills = Skill.all
    if params[:start_date] && params[:end_date]
      form_start_date = Date.strptime(params[:start_date], '%m/%d/%Y')
      form_end_date = Date.strptime(params[:end_date], '%m/%d/%Y')
      @skills = Skill.search(params)
      @skills.reject do |skill|
        skill.bookings.each do |booking|
          form_start_date <= Date.strptime(booking.end_date, '%m/%d/%Y') || form_end_date >= Date.strptime(booking.start_date, '%m/%d/%Y')
          raise
        end
      end
    elsif params[:search]
      @skills = Skill.search(params)
    else
     @skills = Skill.all
    end
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skills_params)
    @skill.user = current_user
    if @skill.save
      redirect_to skill_path(@skill)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @skill.update(skills_params)
    redirect_to skill_path(@skill)
  end

  def destroy
    @skill.destroy
    redirect_to skills_path
  end

  private

  def skills_params
    params.require(:skill).permit(:city, :title, :description, :photo, :photo_cache)
  end

  def set_skill
    @skill = Skill.find(params[:id])
  end
end


