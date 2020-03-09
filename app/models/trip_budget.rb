class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget
  has_many :receipts

  def total_remaining
    self.budget.amount - self.receipts.reduce(0) { |total, receipt| total + receipt.total_amount }
  end

  def budget_percent
    ((self.total_remaining.to_f / self.budget.amount.to_f).round(2) * 100).to_i
  end

  def total_spent
    self.receipts.reduce(0) { |total, receipt| total + receipt.total }
  end
end
