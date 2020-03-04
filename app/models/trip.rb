class Trip < ApplicationRecord
  has_many :receipts
  has_many :trip_users
  has_many :trip_budgets
  has_many :users, through: :trip_users
  has_many :budgets, through: :trip_budgets

  validates :name, :destination, :purpose, :customer, :start_date, :end_date, presence: true

  def total_budget
    self.budgets.reduce(0) { |total, budget| total + budget.amount }
  end

  def total_remaining
    self.trip_budgets.reduce(0) { |total, trip_budget| total + trip_budget.remaining_amount }
  end
end
