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
      redirect_to receipt_path(id: @receipt.id)
    else
      render :new
    end
  end

  def show
    authorize @receipt
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
