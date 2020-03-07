class Trip < ApplicationRecord
  has_many :trip_users, dependent: :destroy
  has_many :trip_budgets, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :budgets, through: :trip_budgets
  has_many :receipts, through: :trip_budgets

  validates :name, :destination, :purpose, :customer, :start_date, :end_date, presence: true

  def total_budget
    self.budgets.reduce(0) { |total, budget| total + budget.amount }
  end

  def total_remaining
    self.total_budget - self.receipts.reduce(0) { |total, receipt| total + receipt.total_amount }
  end

  def budget_percent
    ((self.total_remaining.to_f / self.total_budget.to_f).round(2) * 100).to_i
  end

  def categories
    self.budgets.map { |budget| budget.name }
  end

  def self.total_spend(days)
    @trips = Trip.where("start_date > ?", (Date.today - days))
    @spend = {}
    @trips.each do |trip|
      trip.trip_budgets.each do |trip_budget|
        if @spend[trip_budget.budget.name].nil?
          @spend[trip_budget.budget.name] = (trip_budget.budget.amount - trip_budget.total_remaining)
        else
          @spend[trip_budget.budget.name] += (trip_budget.budget.amount - trip_budget.total_remaining)
        end
      end
    end
    @spend
  end

  def self.location_spend
    @trip_budgets = TripBudget.all
    @spend = {}
    @trip_budgets.each do |trip_budget|
      if @spend[trip_budget.budget.name].nil?
        @spend[trip_budget.trip.destination] = (trip_budget.budget.amount - trip_budget.total_remaining)
      else
        @spend[trip_budget.budget.destination] += (trip_budget.budget.amount - trip_budget.total_remaining)
      end
    end
    @spend.sort_by {|location, amount| amount}.reverse.to_h
  end

  def generate_report
    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Trip ID: #{@trip.id}",
        page_size: 'A4',
        template: "trips/report.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end
end
