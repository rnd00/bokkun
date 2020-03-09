class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget
  has_many :receipts

  def total_remaining
    self.total_amount - self.receipts.reduce(0) { |total, receipt| total + receipt.total }
  end

  def budget_percent
    ((self.total_remaining.to_f / self.total_amount.to_f).round(2) * 100).to_i
  end

  def total_amount
    self.budget.amount * self.trip.length
  end

  def total_spent
    self.receipts.reduce(0) { |total, receipt| total + receipt.total }
  end
end
