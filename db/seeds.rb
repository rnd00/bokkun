# ============================================================================
# SHORTHAND HELPER
# ============================================================================

##
# some of the functions below dependent on this (these) shorthand(s)

today = Date.today

# ============================================================================
# SKELETON GENERATOR FUNCTIONS
# ============================================================================

def user_gen(email, fname, lname, job, manager_status)
  User.create!(
    email: email,
    password: "123456",
    first_name: fname,
    last_name: lname,
    job_title: job,
    manager: manager_status )
end

def trip_gen(name, dest, purpose, customer, sdate, edate)
  Trip.create!(
  name: name,
  destination: dest,
  purpose: purpose,
  customer: customer,
  start_date: sdate,
  end_date: edate )
end

def receipt_gen(company, total, date, tax, user, trip_budget)
  receipt = Receipt.create!(
    company: company,
    total_amount: total,
    date: date,
    tax_amount: tax,
    user: user,
    trip_budget: trip_budget )
end

def budget_gen(name, amount)
  Budget.create!(
    name: name,
    amount: amount )
end

def trip_budget_gen(budget, trip)
  TripBudget.create!(
    trip: trip,
    budget: budget )
end

# ============================================================================
# TEMPLATE GENERATOR FUNCTIONS
# ============================================================================

def temp_budget_gen
  types = [
    # add more type as you need

    ['food', 15000],
    ['travel', 20000],
    ['miscellaneous', 20000],
    ['accomodation', 25000]]
  types.map do |type|
    budget << budget_gen(type[0], type[1])
  end
end

def temp_trip_gen(city, purpose, customer, length_of_trip)
  name = "#{city} trip"
  dest = "#{city}, Earth"
  rand_num = rand(length_of_trip)
  sdate = today - rand_num
  edate = today + (length_of_trip - rand_num)
  trip_gen(name, dest, purpose, customer, sdate, edate)
end

def temp_col_trip_gen(trip_datas)
  trip_datas.map do |trip|
    temp_trip_gen(trip[0], trip[1], trip[2], trip[3])
  end
end

def temp_trip_budget_gen(temp_budget, trip)
  # call this each time you make a trip
  temp_budget.map do |budget|
    trip_budget_gen(budget, trip)
  end
end


# ============================================================================
# SAMPLE DATAS
# ============================================================================

##
# Array inside another array;
# user = [login-email, first-name, last-name, job-title, manager-boolean]
# trip = []

user_datas = [['segawa@bokkun.me', 'Segawa', 'Taku', 'Branch Manager', true],
              ['hirai@bokkun.me', 'Hirai', 'Kako', 'Sales Rep', false],
              ['ueno@bokkun.me', 'Ueno', 'Keisuke', 'Sales Rep', false]]

trip_datas = [["Tokyo Trip", "Tokyo, Japan", "First Contact", "Adil Omary", today - 2, today - 1],
              []]

# ============================================================================
# DESTROY ALL
# ============================================================================

puts "destroy_all everything..."
# join tables first then the data table
TripUser.destroy_all
ReceiptItem.destroy_all
Receipt.destroy_all
Budget.destroy_all
TripBudget.destroy_all
Trip.destroy_all
User.destroy_all
puts "done with destroy_all!"

# ============================================================================
# GENERATE USERS
# ============================================================================

puts "generating default users..."
User.create!( email: "admin@bokkun.me",
  password: "123456",
  first_name: "admin",
  last_name: "bokkun",
  job_title: "admin",
  manager: true)
uemura = user_gen("uemura@bokkun.me", "Uemura", "Mitsuo", "Division Manager", true)
yamada = user_gen("yamada@bokkun.me", "Yamada", "Taro", "Sales Rep", false)

# add another users for tests
user_datas.each do |data|
  user_gen(data[0], data[1], data[2], data[3], data[4])
end
puts "done with user generation!"

# ============================================================================
# GENERATE TRIP, BUDGETS, AND THEIR JOIN TABLES
# ============================================================================

puts "generating 2 trips and budgets..."
temp_budget = temp_budget_gen()

tokyo = trip_gen("Tokyo Trip", "Tokyo, Japan", "First Contact", "Adil Omary", today - 2, today - 1)
fukuoka = trip_gen("Fukuoka Trip", "Fukuoka, Japan", "Currying Favor", "Mike Warren", today, today + 2)
hokkaido = trip_gen("Hokkaido Trip", "Hokkaido, Japan", "Meeting with potential customer", "Suzuki Ichiro", today, today + 3)
izu = trip_gen("Izu Trip", "Izu, Japan", "Meeting with another branch manager", "Takagi Jiro", today + 3, today + 4)
izumo = trip_gen("Izumo Trip", "Izumo, Japan", "Checking out our distributor", "Nakagawa Saburo", today + 5, today + 7)

temp_trip_budget_gen(temp_budget, tokyo)
temp_trip_budget_gen(temp_budget, fukuoka)
temp_trip_budget_gen(temp_budget, hokkaido)
temp_trip_budget_gen(temp_budget, izu)
temp_trip_budget_gen(temp_budget, izumo)
puts "done with trip & budget generation!"

puts "connecting trip-user..."
tu1 = TripUser.create!(
  user: uemura,
  trip: tokyo)
tu2 = TripUser.create(
  user: yamada,
  trip: fukuoka)
tu3 = TripUser.create(
  user: yamada,
  trip: hokkaido)
tu4 = TripUser.create(
  user: uemura,
  trip: izu)
tu5 = TripUser.create(
  user: uemura,
  trip: izumo)
puts "trip-user connected!"

# ============================================================================
# GENERATE RECEIPTS
# ============================================================================

puts "generating 2 receipts..."
sukiya = receipt_gen("Sukiya", "2000", today, 10, yamada, fukuoka.trip_budgets.first)
izakaya = receipt_gen("Izakaya Hopper", "7000", today, 10, yamada, fukuoka.trip_budgets.first)
puts "done with receipts generation!"
