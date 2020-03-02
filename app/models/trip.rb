class Trip < ApplicationRecord
  has_many :receipts
  has_many :trip_users
  has_many :users, through: :trip_users

  validates :name, :destination, :purpose, :customer, :start_date, :end_date, presence: true

end
