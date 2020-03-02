class AddTripBudgetToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :trip_budget, foreign_key: true
  end
end
