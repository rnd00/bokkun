class TripBudget < ApplicationRecord
  belongs_to :trip
  belongs_to :budget
  has_many :receipts
end
