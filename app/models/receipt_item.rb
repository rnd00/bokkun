class ReceiptItem < ApplicationRecord
  belongs_to :receipt

  validates :name, :amount, :tax, presence: true
  validates :amount, :tax, numericality: { only_integer: true }
end
