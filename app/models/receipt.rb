class Receipt < ApplicationRecord
  has_many :receipt_items
  belongs_to :user
  has_one :trip
  has_one :trip_budget

  validates :company, :tax_amount, :total_amount, :date, presence: true
  validates :tax_amount, :total_amount, numericality: { only_integer: true }
end
