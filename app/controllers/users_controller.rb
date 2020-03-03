class UsersController < ApplicationController
  def landing
  end

  def dashboard
    @user = current_user
    authorize @user
  end

end
