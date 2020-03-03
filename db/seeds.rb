# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "destroy_all everything..."
Budget.destroy_all
ReceiptItem.destroy_all
Receipt.destroy_all
TripBudget.destroy_all
TripUser.destroy_all
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
manager_user = User.create!(
  email: "manager@bokkun.me",
  password: "123123",
  first_name: "Uemura",
  last_name: "Mitsuo",
  job_title: "Sales Rep",
  manager: true)
employee_user = User.create!(
  email: "employee@bokkun.me",
  password: "123456",
  first_name: "Yamada",
  last_name: "Taro",
  job_title: "Sales Rep",
  manager: false)
puts "done with user generation!"


