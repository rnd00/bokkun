class Receipt < ApplicationRecord
  has_many :receipt_items
  belongs_to :user
  has_one :trip, through: :trip_budget
  belongs_to :trip_budget
  has_one :budget, through: :trip_budget
  has_one_attached :photo
  before_create :update_remaining_amount

  validates :company, :tax_amount, :total_amount, :date, presence: true
  validates :tax_amount, :total_amount, numericality: { only_integer: true }

  def update_remaining_amount
    trip_budget = self.trip_budget
    trip_budget.amount_remaining -= self.total_amount
    trip_budget.save
  end
end
