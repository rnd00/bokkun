# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# begin generators

def user_gen(email, fname, lname, job, manager_status)
  User.create!(
    email: email,
    password: "123456",
    first_name: fname,
    last_name: lname,
    job_title: job,
    manager: manager_status)
end

def trip_gen(name, dest, purpose, customer, sdate, edate)
  Trip.create!(
  name: name,
  destination: dest,
  purpose: purpose,
  customer: customer,
  start_date: sdate,
  end_date: edate)
end

def trip_budget_gen(name, amount, trip)
  budget = Budget.create!(
    name: name,
    amount: amount )
  TripBudget.create!(
    trip: trip,
    budget: budget,
    remaining_amount: amount )
end

def receipt_gen(company, total, date, tax, cat, user, trip)
  receipt = Receipt.create!(
    company: company,
    total_amount: total,
    date: date,
    tax_amount: tax,
    category: cat,
    user: user,
    trip: trip)
end

def template_trip_budget_gen(trip)
  # add more type as you need
  types = [['meal', 15000], ['travel', 20000], ['accomodations', 20000]]
  types.each do |type|
    trip_budget_gen(type[0], type[1], trip)
  end
end

today = Date.today

# end generators

puts "destroy_all everything..."
# join tables first then the data table
TripBudget.destroy_all
TripUser.destroy_all
ReceiptItem.destroy_all
Budget.destroy_all
Receipt.destroy_all
Trip.destroy_all
User.destroy_all
puts "done with destroy_all!"

puts "generating default users..."
User.create!( email: "admin@bokkun.me",
  password: "123456",
  first_name: "admin",
  last_name: "bokkun",
  job_title: "admin",
  manager: true)
uemura = user_gen("uemura@bokkun.me", "Uemura", "Mitsuo", "Sales Rep", true)
yamada = user_gen("yamada@bokkun.me", "Yamada", "Taro", "Sales Rep", false)
puts "done with user generation!"


puts "generating 2 trips and budgets..."
tokyo = trip_gen("Tokyo Trip", "Tokyo, Japan", "First Contact", "Adil Omary", today - 2, today - 1)
fukuoka = trip_gen("Fukuoka Trip", "Fukuoka, Japan", "Currying Favor", "Mike Warren", today, today + 2)
hokkaido = trip_gen("Hokkaido Trip", "Hokkaido, Japan", "Meeting with potential customer", "Suzuki Ichiro", today, today + 3)
izu = trip_gen("Izu Trip", "Izu, Japan", "Meeting with another branch manager", "Takagi Jiro", today + 3, today + 4)
izumo = trip_gen("Izumo Trip", "Izumo, Japan", "Checking out our distributor", "Nakagawa Saburo", today + 5, today + 7)

template_trip_budget_gen(tokyo)
template_trip_budget_gen(fukuoka)
template_trip_budget_gen(hokkaido)
template_trip_budget_gen(izu)
template_trip_budget_gen(izumo)
puts "done with trip & budget generation!"

puts "connecting trip-user..."
tu1 = TripUser.create!(
  user: uemura,
  trip: tokyo)
tu2 = TripUser.create(
  user: yamada,
  trip: fukuoka)
tu2 = TripUser.create(
  user: yamada,
  trip: hokkaido)
tu2 = TripUser.create(
  user: uemura,
  trip: izu)
tu2 = TripUser.create(
  user: uemura,
  trip: izumo)
puts "trip-user connected!"

puts "generating 2 receipts..."
sukiya = receipt_gen("Sukiya", "2000", today, 10, 'meal', yamada, fukuoka)
izakaya = receipt_gen("Izakaya Hopper", "7000", today, 10, 'meal',yamada, fukuoka)
puts "done with receipts generation!"
