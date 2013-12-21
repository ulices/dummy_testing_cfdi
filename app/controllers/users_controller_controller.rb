class UsersControllerController < ApplicationController
  def edit
  end

  def update
    @user = User.find params[:id]
    @user.certificate_url = params[:file]
    @user.save!
  end
end
