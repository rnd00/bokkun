# ============================================================================
# REQUIRE
# ============================================================================

require 'open-uri'
require 'faker'

# ============================================================================
# SHORTHAND HELPER
# ============================================================================

##
# some of the functions below dependent on this (these) shorthand(s)

TODAY = Date.today

# ============================================================================
# FETCH HELPER
# ============================================================================

##
# getting some avatar; http://le-wagon-tokyo.herokuapp.com/batches/363/student

def fetch_avatar
  url =  'http://le-wagon-tokyo.herokuapp.com/batches/363/student'
  open(url, 'Accept-Language' => 'en').read
end

# ============================================================================
# SKELETON GENERATOR FUNCTIONS
# ============================================================================

def user_gen(email, fname, lname, job, manager_status, avatar)
  User.create!(
    email: email,
    password: "123456",
    first_name: fname,
    last_name: lname,
    job_title: job,
    manager: manager_status,
  avatar: avatar )
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

def budget_gen(name, amount, symbol)
  Budget.create!(
    name: name,
    amount: amount,
  symbol: symbol )
end

def trip_budget_gen(budget, trip)
  TripBudget.create!(
    trip: trip,
  budget: budget )
end

def trip_user_gen(user, trip)
  TripUser.create!(
    user: user,
  trip: trip )
end

# ============================================================================
# TEMPLATE GENERATOR FUNCTIONS
# ============================================================================

def temp_budget_gen
  types = [
    # add more type as you need
    ['Accomodation', 20000, '<i class="fas fa-hotel"></i>'],
    ['Food', 15000, '<i class="fas fa-utensils"></i>'],
    ['Travel', 4000, '<i class="fas fa-train"></i>'],
  ['Miscellaneous', 20000, '<i class="fas fa-tag"></i>']]
  types.map do |type|
    budget_gen(type[0], type[1], type[2])
  end
end

def temp_trip_gen(city, purpose, customer, length_of_trip)
  name = "#{city} trip"
  dest = "#{city}"
  rand_num = rand(length_of_trip)
  sdate = TODAY - rand_num
  edate = TODAY + (length_of_trip - rand_num)
  trip_gen(name, dest, purpose, customer, sdate, edate)
end

# collection generator (output = array)

def temp_users_gen(data)
  data.map do |user|
    avatar = fetch_avatar
    user_gen(user[0], user[1], user[2], user[3], user[4], avatar)
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

USERDATA = [['segawa@bokkun.me', 'Taku', 'Segawa', 'Branch Manager', true],
            ['hirai@bokkun.me', 'Kako', 'Hirai', 'Sales Rep', false],
            ['y.hisoka@bokkun.me', 'Hisoka', 'Yamazaki', 'Sales Rep', false],
            ['tanimoto@bokkun.me', 'Takao', 'Tanimoto', 'Sales Rep', false],
            ['seo@bokkun.me', 'Chiyo', 'Seo', 'Sales Rep', false],
            ['ueno@bokkun.me', 'Keisuke', 'Ueno', 'Sales Rep', false]]

TRIPDATA = [["Tokyo", "First contact", "Adil Omary", 3],
            ["Fukuoka", "Currying favor", "Mike Warren", 4],
            ["Susukino", "Meeting with potential customer", "Suzuki Ichiro", 1],
            ["Izu", "Meeting with another branch manager", "Takagi Jiro", 2],
            ["Izumo", "Checking out our distributor", "Nakagawa Saburo", 3],
            ["Oita", "Opening workshops on an Institute", "Kanzaki Shiro", 4],
            ["Gunma", "Attending a Convention", "Kikuchi Goro", 5]]

# DO NOT USE IT YET
# RECEIPTDATA = [["Sukiya", "2000", TODAY, 10, adil, fukuoka.trip_budgets.first]]


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
puts "...finished with destroy_all!"

# ============================================================================
# GENERATE USERS
# ============================================================================

puts "\nGenerating default users..."
# the default users for all

# ----------------------------------------------------------------------------
# THIS IS MIKE
# ----------------------------------------------------------------------------
# User.create!( email: "mike@bokkun.me",
#   password: "123456",
#   first_name: "Mike",
#   last_name: "Warren",
#   job_title: "CEO, Superintentdent General of Bokk* Holdings Corp",
#   manager: true,
#   avatar: 'https://avatars0.githubusercontent.com/u/28691463?s=460&v=4')
# ----------------------------------------------------------------------------

# two users we want to use for presentations
# mike = user_gen("mike@bokkun.me", "Mitsuo", "mike", "Division Manager", true, fetch_avatar)
# adil = user_gen("adil@bokkun.me", "Taro", "adil", "Sales Rep", false, fetch_avatar)
mike = user_gen("mike@bokkun.me", "Mike", "Warren", "Division Manager", true, 'https://avatars0.githubusercontent.com/u/28691463?s=460&v=4')
adil = user_gen("adil@bokkun.me", "Adil", "Omary", "Sales Rep", false, 'https://avatars0.githubusercontent.com/u/59479470?s=400&v=4')

TESTUSERS = [mike, adil]

# add another users for tests
puts "\nGenerating dummy users..."
users = temp_users_gen(USERDATA)
puts "...finished with user generation!"

# ============================================================================
# GENERATE TRIP, BUDGETS, AND JOIN TABLES
# ============================================================================

puts "\nGenerating trips and budgets..."
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
trip_user_gen(adil, chiba)
temp_trip_budget_gen(TEMPBUDGET, chiba)
puts "...finished with connections"

# ============================================================================
# GENERATE RECEIPTS
# ============================================================================

puts "\nGenerating 2 receipts for adil..."
# get all 4 budgets instances
food = adil.trips.last.budgets.find_by(name: 'Food')
trav = adil.trips.last.budgets.find_by(name: 'Travel')
acco = adil.trips.last.budgets.find_by(name: 'Accomodation')
misc = adil.trips.last.budgets.find_by(name: 'Miscellaneous')

# defining all the trip-budget types
adil_food = adil.trips.last.trip_budgets.find_by(budget: food)
adil_trav = adil.trips.last.trip_budgets.find_by(budget: trav)
adil_acco = adil.trips.last.trip_budgets.find_by(budget: acco)
adil_misc = adil.trips.last.trip_budgets.find_by(budget: misc)

# get the time for the last trip (ends on 3 days)
START = adil.trips.last.start_date

# template = receipt_gen(company, total, date, tax, user, trip_budget)
konbini = receipt_gen("Convenience Store", "1230", START + 1, 10, adil, adil_food)
distillery = receipt_gen("Omary's Umeshu Distillery", "3300", START + 1, 10, adil, adil_food)
bar = receipt_gen("Bar Heise & Warren", "3700", START + 2, 10, adil, adil_food)

train_one = receipt_gen("Train (Shinjuku - Chiba)", "814", START, 10, adil, adil_trav)
train_two = receipt_gen("Train (Chiba - Shinjuku)", "814", START + 2, 10, adil, adil_trav)

hotel = receipt_gen("Hotel", "9500", START, 10, adil, adil_acco)
ryokan = receipt_gen("Ryokan", "10500", START + 1, 10, adil, adil_acco)

# adil_RECEIPTS = [konbini, distillery, bar]

puts "...finished with receipts generation!"

# ============================================================================
# GENERATE RECEIPT ITEMS
# ============================================================================

puts "\nGenerating items on adil's food receipts..."

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

puts "...finished with receipt items generation!"

# ============================================================================
# GENERATE DUMMIES FOR GRAPH TESTING
# ============================================================================

PREFECTURES = [ "Fukushima",
                "Saitama",
                "Chiba",
                "Tokyo",
                "Kanagawa",
                "Osaka",
                "Okinawa"]

puts "\nGenerating random past trips"
user = User.find_by(last_name: "Warren") # was mike
20.times do
  random = rand(10..100)
  trip = Trip.create!(
    destination: PREFECTURES.sample,
    purpose: "making sales",
    customer: Faker::Company.name,
    start_date: Date.today - random,
    end_date: Date.today - random + rand(0..10)
  )
  trip.name = "Trip to #{trip.destination} to visit #{trip.customer}"
  trip.save
  TripUser.create!(
    user: user,
    trip: trip
  )
  Budget.all.each do |budget|
    TripBudget.create!(
      trip: trip,
      budget: budget
    )
  end
end
puts "...finished!"

puts "\nGenerating receipts..."
Trip.all.each do |trip|
  trip.trip_budgets.each do |trip_budget|
    (trip.length).times do
      if trip_budget.budget.name == "Accomodation"
        Receipt.create!(
          company: ['Comfort Inn', 'Tokyo Hotel'].sample,
          date: trip.start_date + rand(0..(trip.end_date - trip.start_date).to_i),
          user: trip.users.take,
          total_amount: 1000,
          trip_budget: trip_budget
        )
      elsif trip_budget.budget.name == "Travel"
        Receipt.create!(
          company: ['JR', 'Kanto Bus', 'Keisei Electric Railway'].sample,
          date: trip.start_date + rand(0..(trip.end_date - trip.start_date).to_i),
          user: trip.users.take,
          total_amount: 1000,
          trip_budget: trip_budget
        )
      else
        Receipt.create!(
          company: Faker::Restaurant.name,
          date: trip.start_date + rand(0..(trip.end_date - trip.start_date).to_i),
          user: trip.users.take,
          total_amount: 1000,
          trip_budget: trip_budget
        )
      end
    end
  end
end
puts "...finished!"

puts "\nGenerating receipt items..."
Receipt.all.each do |receipt|
  if receipt.budget.name == 'Accomodation'
    item = ReceiptItem.create!(
      name: ['Single room', 'Double'].sample,
      tax: [8, 10].sample,
      receipt: receipt,
      amount: rand(1..5) * 3000
    )
    receipt.total_amount += item.amount
    receipt.save!
  elsif receipt.budget.name == 'Travel'
    item = ReceiptItem.create!(
      name: ['Train', 'Shinkansen', 'Express Bus'].sample,
      tax: [8, 10].sample,
      receipt: receipt,
      amount: rand(1..5) * 1000
    )
    receipt.total_amount += item.amount
    receipt.save!
  else
    rand(1..3).times do
      break if receipt.trip_budget.total_remaining < 10000
      item = ReceiptItem.create!(
        name: Faker::Food.dish,
        tax: [8, 10].sample,
        receipt: receipt,
        amount: rand(1..10) * rand(1..10) * 10
      )
      receipt.total_amount += item.amount
      receipt.save!
    end
  end
end
puts "...finished!"
