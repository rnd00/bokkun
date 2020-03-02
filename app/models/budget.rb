class Budget < ApplicationRecord

  validates :name, :amount, presence: true
  validates :amount, numericality: { only_integer: true }
end
