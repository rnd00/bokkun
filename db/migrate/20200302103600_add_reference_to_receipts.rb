class AddReferenceToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :trip, foreign_key: true
  end
end
