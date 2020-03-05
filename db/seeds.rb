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
  Receipt.create!(
    company: company,
    total_amount: total,
    date: date,
    tax_amount: tax,
    user: user,
    trip_budget: trip_budget )
end

def items_gen(name, amt, tax, receipt)
  ReceiptItem.create!(
    name: name,
    amount: amt,
    tax: tax,
    receipt: receipt )
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

def temp_trip_gen(city, purpose, customer, length_of_trip)
  name = "#{city} trip"
  dest = "#{city}, Japan"
  rand_num = rand(length_of_trip)
  sdate = TODAY - rand_num
  edate = TODAY + (length_of_trip - rand_num)
  trip_gen(name, dest, purpose, customer, sdate, edate)
end

# collection generator (output = array)

def temp_users_gen(data)
  data.map do |user|
    user_gen(user[0], user[1], user[2], user[3], user[4])
  end
end

def temp_col_trip_gen(data)
  data.map do |trip|
    temp_trip_gen(trip[0], trip[1], trip[2], trip[3])
  end
end

def temp_col_receipt_gen(data, user, trip_budget)
  data.map do |receipt|
    # receipt_gen(company, total, date, tax, user, trip_budget)
    receipt_gen(receipt[0], receipt[1], receipt[2], receipt[3], user, trip_budget)
  end
end

# join tables (output = array)

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
# trip = [city (has to be inside japan), purpose, customer, length-of-trip]

USERDATA = [['segawa@bokkun.me', 'Segawa', 'Taku', 'Branch Manager', true],
              ['hirai@bokkun.me', 'Hirai', 'Kako', 'Sales Rep', false],
              ['ueno@bokkun.me', 'Ueno', 'Keisuke', 'Sales Rep', false]]

TRIPDATA = [["Tokyo", "First contact", "Adil Omary", 3],
              ["Fukuoka", "Currying favor", "Mike Warren", 4],
              ["Susukino", "Meeting with potential customer", "Suzuki Ichiro", 1],
              ["Izu", "Meeting with another branch manager", "Takagi Jiro", 2],
              ["Izumo", "Checking out our distributor", "Nakagawa Saburo", 3],
              ["Oita", "Opening workshops on an Institute", "Kanzaki Shiro", 4],
              ["Gunma", "Attending a Convention", "Kikuchi Goro", 5]]

# DO NOT USE IT YET
# RECEIPTDATA = [["Sukiya", "2000", TODAY, 10, yamada, fukuoka.trip_budgets.first]]


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

TESTUSERS = [uemura, yamada]

# add another users for tests
puts "generating dummy users..."
users = temp_users_gen(USERDATA)
puts "done with user generation!"

# ============================================================================
# GENERATE TRIP, BUDGETS, AND JOIN TABLES
# ============================================================================

puts "generating trips and budgets..."
TEMPBUDGET = temp_budget_gen()
TEMPTRIPS = temp_col_trip_gen(TRIPDATA)
puts "trips and budgets are ready"

puts "connecting trips-budgets-(TESTUSERS)"
# iteration for join table
TEMPTRIPS.each do |trip|
  temp_trip_budget_gen(TEMPBUDGET, trip)
  trip_user_gen(TESTUSERS.sample, trip)
end
# safety net
chiba = temp_trip_gen("Chiba", "Inspecting the next company trip", "Shinagawa Kouki", 3)
trip_user_gen(yamada, chiba)
temp_trip_budget_gen(TEMPBUDGET, chiba)
puts "done with connections"

# ============================================================================
# GENERATE RECEIPTS
# ============================================================================

puts "generating 2 receipts for yamada..."
yamada_trip_budget = yamada.trips.first.trip_budgets.last

# template = receipt_gen(company, total, date, tax, user, trip_budget)
konbini = receipt_gen("Convenience Store", "1230", TODAY, 10, yamada, yamada_trip_budget)
distillery = receipt_gen("Omary's Umeshu Distillery", "3300", TODAY, 10, yamada, yamada_trip_budget)
bar = receipt_gen("Craft Beer Bar Heise & Warren", "3700", TODAY, 10, yamada, yamada_trip_budget)

# YAMADA_RECEIPTS = [konbini, distillery, bar]

puts "done with receipts generation!"

# ============================================================================
# GENERATE RECEIPT ITEMS
# ============================================================================

puts "generating items on Yamada's receipts..."

# template = items_gen(name, amt, tax, receipt)
gyudon = items_gen('Gyudon', 450, 10, konbini)
peanut = items_gen('Peanut Butter Jam', 280, 10, konbini)
tissue = items_gen('Kleenex Ultra Soft', 400, 10, konbini)

permit = items_gen('Entry Ticket + 10 Free Drinks', 2500, 10, distillery)
umeshu = items_gen('Yamagata Masamune Aged Umeshu', 800, 10, distillery)

hotdog = items_gen("Warren's Famous Skinless Beef Franks", 1200, 10, bar)
kimchi = items_gen("Heise's Medium Spicy Kimchi", 550, 10, bar)
kiuchi = items_gen('Kiuchi Craft Beer', 800, 10, bar)
shochu = items_gen('Iichiko Shochu', 600, 10, bar)
cheese = items_gen('Cheesecake', 550, 10, bar)

puts "done with receipt items generation!"
