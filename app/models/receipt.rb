class Receipt < ApplicationRecord
  has_many :receipt_items, dependent: :destroy
  belongs_to :user
  belongs_to :trip_budget
  has_one :trip, through: :trip_budget
  has_one :budget, through: :trip_budget
  has_one_attached :photo

  validates :company, :total_amount, :date, presence: true
  validates :total_amount, numericality: { only_integer: true }

  def category
    self.budget.name
  end
end
