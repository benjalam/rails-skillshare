class SkillsController < ApplicationController

  def index
    @skills = Skill.all
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skills_params)
    if @skill.save
      redirect_to skill_path(@skill)
    else
      render :new
    end
  end

  private

    def skills_params
      params.require(:skill).permit(:city, :title, :description)
    end
end
