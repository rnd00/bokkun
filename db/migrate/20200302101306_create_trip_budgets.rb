class CreateTripBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_budgets do |t|
      t.references :trip, foreign_key: true
      t.references :budget, foreign_key: true
      t.integer :remaining_amount

      t.timestamps
    end
  end
end
