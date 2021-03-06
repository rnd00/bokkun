class Trip < ApplicationRecord
  has_many :trip_users, dependent: :destroy
  has_many :trip_budgets, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :budgets, through: :trip_budgets
  has_many :receipts, through: :trip_budgets, dependent: :destroy
  has_many :receipt_items, through: :receipts, dependent: :destroy

  validates :destination, :purpose, :customer, :start_date, :end_date, presence: true

  def active?
    Date.today <= self.end_date && Date.today >= self.start_date
  end

  def receipts_sort_date
    self.receipts.order(:date)
  end

  def total_budget
    self.trip_budgets.reduce(0) { |total, trip_budget| total + trip_budget.total_amount }
  end

  def total_remaining
    self.total_budget - self.total_spent
  end

  def total_tax
    self.receipts.reduce(0) { |total, receipt| total + receipt.total_tax }
  end

  def total_spent
    self.receipts.reduce(0) { |total, receipt| total + receipt.total }
  end

  def budget_percent
    ((self.total_remaining.to_f / self.total_budget.to_f).round(2) * 100).to_i
  end

  def categories
    self.budgets.map { |budget| budget.name }
  end

  # this go by only taking the receipt's total_amount (faster)
  def self.total_spend(days)
    result = {}
    query = Trip.joins(receipts: :budget).select('budgets.name, SUM(receipts.total_amount) AS total').group('budgets.name').where("start_date > ?", (Date.today - days))
    query.map do |element|
      result[element[:name]] = element[:total]
    end
    result
  end

  def total_spend
    result = {}
    query = Trip.joins(receipt_items: :budget).select('budgets.name, SUM( receipt_items.amount * ( ( receipt_items.tax / 100.0 ) + 1.0 )) AS total').group('budgets.name').order(total: :desc).where("trips.id = #{id}")
    query.map do |element|
      result[element[:name]] = element[:total].round
    end
    result
  end

  # this go with only one queries
  def self.location_spend
    query = Trip.joins(:receipts).select('destination, SUM(total_amount) AS total').group(:destination).order(total: :desc).limit(5)
    query.map do |element|
      { name: element[:destination], data: { "Total Spending" => element[:total] } }
    end
  end

  # this go by getting sum of the receipt items' price (lags)
  def self.old_total_spend(days)
    @trips = Trip.where("start_date > ?", (Date.today - days))
    @spend = {}
    @trips.each do |trip|
      trip.trip_budgets.each do |trip_budget|
        if @spend[trip_budget.budget.name].nil?
          @spend[trip_budget.budget.name] = (trip_budget.total_spent)
        else
          @spend[trip_budget.budget.name] += (trip_budget.total_spent)
        end
      end
    end
    @spend
  end

  # n+1 problems described by adil's friend
  def self.old_location_spend
    @trip_budgets = TripBudget.all
    @spend = {}
    @trip_budgets.each do |trip_budget|
      if @spend[trip_budget.budget.name].nil?
        @spend[trip_budget.trip.destination] = (trip_budget.total_spent)
      else
        @spend[trip_budget.budget.destination] += (trip_budget.total_spent)
      end
    end
    @spend.sort_by {|location, amount| amount}.reverse.to_h
  end

  def length
    (self.end_date - self.start_date).to_i + 1
  end

  include PgSearch::Model
  pg_search_scope :search_all,
    against: [ :name, :destination, :purpose, :customer, :start_date, :end_date ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
