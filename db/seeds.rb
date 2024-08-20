# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "destroying all stuff..."
Task.destroy_all
Household.destroy_all
User.destroy_all

max = User.create!({
  username: "max",
  email: "max@gmail.com",
  password: "maxmaxmax"
})

household = Household.create({ title: "ChoreQuest", user: max })

max.household = household


User.create!({
  username: "mia",
  email: "mia@gmail.com",
  password: "miamiamia",
  household: household
})

User.create!({
  username: "yu",
  email: "yu@gmail.com",
  password: "yuyuyu",
  household: household
})

User.create!({
  username: "akitaka",
  email: "akitaka@gmail.com",
  password: "akitaka",
  household: household
})

30.times do
  Task.create({
    category: Task::CATEGORIES.sample,
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    user: User.all.sample,
    household: household,
    frequency: rand(1..10)
  })
end

puts "finished seeding! :)"
