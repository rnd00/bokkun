module Employee
  class UsersController < ApplicationController

    def dashboard
      @user = current_user
      @current_trip = @user.trips.order(start_date: :desc).first
      @query = params[:query]
      authorize @user
      if params[:query].present?
        @trips = Trip.search_all(params[:query])
      else
        @trips = @user.trips.order(start_date: :desc)
      end
    end

    def show
      @user = User.find_by(id: params[:id])
      authorize @user
    end

  end
end
