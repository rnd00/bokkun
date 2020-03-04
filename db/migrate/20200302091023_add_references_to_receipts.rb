class AddReferencesToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :user, foreign_key: true
  end
end
