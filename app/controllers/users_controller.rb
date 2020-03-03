class UsersController < ApplicationController
  def landing
  end

  def dashboard
    @user = current_user
    authorize @user
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

end
