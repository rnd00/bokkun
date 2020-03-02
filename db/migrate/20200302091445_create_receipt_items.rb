class CreateReceiptItems < ActiveRecord::Migration[5.2]
  def change
    create_table :receipt_items do |t|
      t.string :name
      t.integer :amount
      t.integer :tax
      t.references :receipt, foreign_key: true

      t.timestamps
    end
  end
end
