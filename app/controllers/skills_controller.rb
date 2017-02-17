class SkillsController < ApplicationController
  before_action :set_skill, only: [ :show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def index
    @skills = Skill.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@skills) do |skill, marker|
      marker.lat skill.latitude
      marker.lng skill.longitude
    end

    if params[:start_date].nil? && params[:end_date].nil? && params[:search].nil?
      @skillsb = @skills
    elsif params[:search] && (params[:start_date] == "" || params[:start_date].nil?)
      @skillsb = Skill.search(params)
    else
      form_start_date = Date.strptime(params[:start_date], '%d-%m-%Y')
      form_end_date = Date.strptime(params[:end_date], '%d-%m-%Y')
      @skills = Skill.search(params)
      @skillsb = @skills.reject do |skill|
        skill.available?(skill, form_start_date, form_end_date)
      end
    end
  end

  def show
    @skill = Skill.find(params[:id])
    @hash = Gmaps4rails.build_markers(@skill) do |skill, marker|
      marker.lat skill.latitude
      marker.lng skill.longitude
    end
    @booking = Booking.new
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
    redirect_to user_path(@skill.user)
  end

  private

  def skills_params
    params.require(:skill).permit(:city, :title, :description, :photo, :photo_cache, :price)
  end

  def set_skill
    @skill = Skill.find(params[:id])
  end
end


