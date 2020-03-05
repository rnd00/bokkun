class ReceiptsController < ApplicationController
  def new
    @receipt = Receipt.new
    @trip = Trip.find_by(id: params[:trip_id])
    @receipt.trip = @trip
    @receipt.user = current_user
    authorize @receipt
  end

  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.user = current_user
    @receipt.trip = Trip.find_by(id: params[:trip_id])
    authorize @receipt
    if @receipt.save
      redirect_to receipt_path(@receipt)
    else
      render :new
    end
  end

  def show
    @receipt = Receipt.find_by(id: params[:id])
    @receipt_item = ReceiptItem.new
    authorize @receipt
  end

  def edit
    @receipt = Receipt.find_by(id: params[:id])
    @trip = @receipt.trip
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
    authorize @receipt
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
    params.require(:receipt).permit(:company, :total_amount, :date, :tax_amount, :user_id, :category, :trip_budget_id, :photo)
  end
end
