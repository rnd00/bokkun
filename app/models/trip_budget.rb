class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget
  has_many :receipts

  def total_spent
    self.receipts.reduce(0) { |total, receipt| total + receipt.total_amount }
  end
end
