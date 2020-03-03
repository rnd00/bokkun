class ReceiptsController < ApplicationController
  def new
    @receipt = Receipt.new
    authorize @receipt
  end

  def create
    @receipt = Receipt.new(receipt_params)
    authorize @receipt
    @receipt.user = @user
    @receipt.trip = @trip
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
    redirect_to dashboard_path
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def receipt_params
    params.require(:receipt).permit(:company, :total_amount, :date, :tax_amount, :user_id, :category, :trip_id)
  end
end
