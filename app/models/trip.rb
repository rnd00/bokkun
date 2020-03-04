class Trip < ApplicationRecord
  has_many :trip_users, dependent: :destroy
  has_many :trip_budgets, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :budgets, through: :trip_budgets
  has_many :receipts, through: :trip_budgets

  validates :name, :destination, :purpose, :customer, :start_date, :end_date, presence: true

  def total_budget
    self.budgets.reduce(0) { |total, budget| total + budget.amount }
  end

  def total_remaining
    self.receipts.reduce(0) { |total, receipt| total + receipt.total_amount }
  end

  def budget_percent
    ((self.total_remaining.to_f / self.total_budget.to_f).round(2) * 100).to_i
  end

  def categories
    self.budgets.map { |budget| budget.name }
  end
end
