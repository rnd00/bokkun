# ============================================================================
# SHORTHAND HELPER
# ============================================================================

##
# some of the functions below dependent on this (these) shorthand(s)

TODAY = Date.today

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

def trip_user_gen(user, trip)
  TripUser.create!(
    user: user,
    trip: trip)
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
    budget_gen(type[0], type[1])
  end
end

def temp_users_gen(data)
  data.map do |user|
    user_gen(user[0], user[1], user[2], user[3], user[4])
  end
end

def temp_trip_gen(city, purpose, customer, length_of_trip)
  name = "#{city} trip"
  dest = "#{city}, Earth"
  rand_num = rand(length_of_trip)
  sdate = TODAY - rand_num
  edate = TODAY + (length_of_trip - rand_num)
  trip_gen(name, dest, purpose, customer, sdate, edate)
end

def temp_col_trip_gen(data)
  data.map do |trip|
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

user_data = [['segawa@bokkun.me', 'Segawa', 'Taku', 'Branch Manager', true],
              ['hirai@bokkun.me', 'Hirai', 'Kako', 'Sales Rep', false],
              ['ueno@bokkun.me', 'Ueno', 'Keisuke', 'Sales Rep', false]]

trip_data = [["Tokyo", "First contact", "Adil Omary", 3],
              ["Fukuoka", "Currying favor", "Mike Warren", 4],
              ["Susukino", "Meeting with potential customer", "Suzuki Ichiro", 1],
              ["Izu", "Meeting with another branch manager", "Takagi Jiro", 2],
              ["Izumo", "Checking out our distributor", "Nakagawa Saburo", 3],
              ["Oita", "Opening workshops on an Institute", "Kanzaki Shiro", 4],
              ["Gunma", "Attending a Convention", "Kikuchi Goro", 5]]



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
# the default users for all
User.create!( email: "mike@bokkun.me",
  password: "123456",
  first_name: "Mike",
  last_name: "Warren",
  job_title: "Bokkun Admin",
  manager: true)
# two users we want to use for presentations
uemura = user_gen("uemura@bokkun.me", "Uemura", "Mitsuo", "Division Manager", true)
yamada = user_gen("yamada@bokkun.me", "Yamada", "Taro", "Sales Rep", false)

test_users = [uemura, yamada]

# add another users for tests
users = temp_users_gen(user_data)
puts "done with user generation!"

# ============================================================================
# GENERATE TRIP, BUDGETS, AND JOIN TABLES
# ============================================================================

puts "generating trips and budgets..."
temp_budget = temp_budget_gen()
trips = temp_col_trip_gen(trip_data)
puts "trips and budgets are ready"

puts "connecting trips-budgets-(test-users)"
# iteration for join table
trips.each do |trip|
  temp_trip_budget_gen(temp_budget, trip)
  trip_user_gen(test_users.sample, trip)
end
puts "done with connections"

# ============================================================================
# GENERATE RECEIPTS
# ============================================================================

# puts "generating 2 receipts..."
# sukiya = receipt_gen("Sukiya", "2000", TODAY, 10, yamada, fukuoka.trip_budgets.first)
# izakaya = receipt_gen("Izakaya Hopper", "7000", TODAY, 10, yamada, fukuoka.trip_budgets.first)
# puts "done with receipts generation!"
