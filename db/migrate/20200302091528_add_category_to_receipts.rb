class AddCategoryToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :category, :string
  end
end
