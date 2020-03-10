class AddSymbolToBudgets < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :symbol, :string
  end
end
