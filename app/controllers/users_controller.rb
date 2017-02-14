class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  mount_uploader :photo, PhotoUploader

end
