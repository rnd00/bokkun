class ChangeColumnInReceiptItems < ActiveRecord::Migration[5.2]
  def change
    change_column :receipt_items, :tax, :integer, default: 8
  end
end
