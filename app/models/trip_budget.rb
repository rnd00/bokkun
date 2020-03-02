class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget

  validates :remaining_amount, numericality: { only_integer: true }
end
