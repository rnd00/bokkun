class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
  end

  def export
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
  end
end
