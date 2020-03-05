class ReceiptItemsController < ApplicationController
  def new
    @receipt = Receipt.find_by(id: params[:receipt_id])
    @receipt_item = ReceiptItem.new
    authorize @receipt_item
  end

  def create
    @receipt_item = ReceiptItem.new(receipt_item_params)
    authorize @receipt_item
    if @receipt_item.save
      redirect_to receipt_path(@receipt_item.receipt)
    else
      render :new
    end
  end

  def edit
    @receipt_item = ReceiptItem.find_by(id: params[:id])
    authorize @receipt_item
  end

  def update
    @receipt_item = ReceiptItem.find_by(id: params[:id])
    authorize @receipt_item
    if @receipt_item.update(receipt_item_params)
      redirect_to receipt_path(@receipt_item.receipt)
    else
      render :edit
    end
  end

  def destroy
    @receipt_item = ReceiptItem.find_by(id: params[:id])
    authorize @receipt_item
    @receipt_item.destroy
    redirect_to receipt_path(@receipt_item.receipt)
  end

  private

  def receipt_item_params
    params.require(:receipt_item).permit(:name, :amount, :tax, :receipt_id)
  end
end
