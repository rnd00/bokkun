# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# begin generators

def trip_budget_gen(name, amount, trip)
  budget = Budget.create!(
    name: name,
    amount: amount )
  TripBudget.create!(
    trip: trip,
    budget: budget,
    remaining_amount: amount )
end

# end generators

puts "destroy_all everything..."
# join tables first then the data table
TripBudget.destroy_all
TripUser.destroy_all
ReceiptItem.destroy_all
Budget.destroy_all
Trip.destroy_all
User.destroy_all
Receipt.destroy_all
puts "done with destroy_all!"

puts "generating default users..."
User.create!( email: "admin@bokkun.me",
  password: "123456",
  first_name: "admin",
  last_name: "bokkun",
  job_title: "admin",
  manager: true)
uemura = User.create!(
  email: "manager@bokkun.me",
  password: "123123",
  first_name: "Uemura",
  last_name: "Mitsuo",
  job_title: "Sales Rep",
  manager: true)
yamada = User.create!(
  email: "employee@bokkun.me",
  password: "123456",
  first_name: "Yamada",
  last_name: "Taro",
  job_title: "Sales Rep",
  manager: false)
puts "done with user generation!"


puts "generating 2 trips and budgets..."
tokyo = Trip.create!(
  name: "Tokyo Trip",
  destination: "Tokyo, Japan",
  purpose: "First Contact",
  customer: "Adil Omary",
  start_date: Date.today - 2,
  end_date: Date.today - 1)

trip_budget_gen("meal", 15000, tokyo)
trip_budget_gen("travel", 15000, tokyo)
trip_budget_gen("accomodations", 15000, tokyo)

fukuoka = Trip.create!(
  name: "Fukuoka Trip",
  destination: "Fukuoka, Japan",
  purpose: "Currying favor",
  customer: "Mike Warren",
  start_date: Date.today,
  end_date: Date.today + 2)

trip_budget_gen("meal", 15000, tokyo)
trip_budget_gen("travel", 15000, tokyo)
trip_budget_gen("accomodations", 15000, tokyo)

puts "done with trip & budget generation!"

puts "connecting trip-user..."
tu1 = TripUser.create!(
  user: uemura,
  trip: tokyo)
tu2 = TripUser.create(
  user: yamada,
  trip: fukuoka)
puts "trip-user connected!"
