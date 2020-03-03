class UsersController < ApplicationController
  def landing
  end

  def dashboard

  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

end
