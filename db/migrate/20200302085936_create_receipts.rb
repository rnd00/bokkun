class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.string :company
      t.integer :total_amount
      t.date :date
      t.integer :tax_amount

      t.timestamps
    end
  end
end
