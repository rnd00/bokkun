module Employee
  class UsersController < ApplicationController

    def dashboard
      @user = current_user
      @trips = @user.trips.order(start_date: :desc)
      authorize @user
    end

    def show
      @user = User.find_by(id: params[:id])
      authorize @user
    end

  end
end
