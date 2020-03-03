class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
  end

  def export
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
    if @trip.update(trip_params)
      redirect_to trip_path(@path)
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    @trip.destroy
    redirect_to dashboard_path
  end
  private

  def trip_params
    params.require(:trip).permit(:name, :destination, :purpose, :customer, :start_date, :end_date)
  end
end
