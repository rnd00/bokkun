class TripsController < ApplicationController

  def index
    @trips = policy_scope(Trip)
  end

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
    @employees = User.all
    @budgets = Budget.all
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    @employees = []
    @budgets = []
    params[:trip][:user_ids].each do |user_id|
      @employees << User.find_by(id: user_id)
    end
    params[:trip][:budget_ids].each do |budget_id|
      @budgets << Budget.find_by(id: budget_id)
    end
    if @trip.save
      @employees.each do |employee|
        TripUser.create!(user: employee, trip: @trip)
      end
      @budgets.each do |budget|
        TripBudget.create!(trip: @trip, budget: budget)
      end
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
    @users = params['trip']['user_ids']
    @trip.trip_users.destroy_all
    @users.each do |user|
      @trip.trip_users.build(user_id: user, trip: @trip)
    end
    authorize @trip
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    authorize @trip
    @trip.destroy
    redirect_to employer_dashboard_path
  end
  private

  def trip_params
    params.require(:trip).permit(:name, :destination, :purpose, :customer, :start_date, :end_date, :user)
  end
end
