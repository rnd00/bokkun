class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget
  has_many :receipts

  validates :remaining_amount, numericality: { only_integer: true }

  def save
    self.remaining_amount = self.budget.amount if self.remaining_amount.nil?
    super
  end
end
