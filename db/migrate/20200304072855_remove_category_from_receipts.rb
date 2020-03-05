class RemoveCategoryFromReceipts < ActiveRecord::Migration[5.2]
  def change
    remove_column :receipts, :category, :string
  end
end
