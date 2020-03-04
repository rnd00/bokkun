class ReceiptsController < ApplicationController
  def new
    @receipt = Receipt.new
    @trip = Trip.find_by(id: params[:trip_id])
    authorize @receipt
  end

  def create
    @receipt = Receipt.new(receipt_params)
    authorize @receipt
    @receipt.user = current_user
    @receipt.trip = Trip.find_by(id: params[:trip_id])
    if @receipt.save
      redirect_to receipt_path(@receipt)
    else
      render :new
    end
  end

  def show
    @receipt = Receipt.find_by(id: params[:id])
    authorize @receipt
  end

  def edit
    @receipt = Receipt.find_by(id: params[:id])
    authorize @receipt
  end

  def update
    @receipt = Receipt.find_by(id: params[:id])
    authorize @receipt
    if @receipt.update(receipt_params)
      redirect_to receipt_path(@receipt)
    else
      render :edit
    end
  end

  def destroy
    @receipt = Receipt.find_by(id: params[:id])
    @receipt.destroy
    if current_user.manager
      redirect_to employer_dashboard_path
    else
      redirect_to employee_dashboard_path
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def receipt_params
    params.require(:receipt).permit(:company, :total_amount, :date, :tax_amount, :user_id, :category, :trip_id, :photo)
  end
end
