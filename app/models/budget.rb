class Budget < ApplicationRecord
  has_many :trip_budgets, dependent: :destroy
  has_many :trips, through: :trip_budgets
  has_many :receipts, through: :trip_budgets
  has_many :receipt_items, through: :receipts

  validates :name, :amount, presence: true
  validates :amount, numericality: { only_integer: true }

  def capitalize_name
    self.name.capitalize
  end
end
