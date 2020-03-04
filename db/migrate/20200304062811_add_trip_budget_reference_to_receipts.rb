class AddTripBudgetReferenceToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :trip_budget, foreign_key: true
    remove_reference :receipts, :trip
  end
end
