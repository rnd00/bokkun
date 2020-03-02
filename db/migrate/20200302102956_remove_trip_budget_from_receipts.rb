class RemoveTripBudgetFromReceipts < ActiveRecord::Migration[5.2]
  def change
    remove_column :receipts, :trip_budget_id, :references
  end
end
