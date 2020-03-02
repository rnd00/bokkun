class Trip < ApplicationRecord
  has_many :receipts
  has_many :trip_users
  has_many :trip_budgets
  has_many :users, through: :trip_users
  has_many :budgets, through: :trip_budgets

  validates :name, :destination, :purpose, :customer, :start_date, :end_date, presence: true
end
