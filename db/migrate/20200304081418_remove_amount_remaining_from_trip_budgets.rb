class RemoveAmountRemainingFromTripBudgets < ActiveRecord::Migration[5.2]
  def change
    remove_column :trip_budgets, :remaining_amount, :integer
  end
end
