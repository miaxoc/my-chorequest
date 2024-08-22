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
Submission.destroy_all
Task.destroy_all
User.update_all(household_id: nil)
Household.destroy_all
User.destroy_all

task_titles = {
  "Vacuum the living room" => "weekly",
  "Wash the dishes" => "daily",
  "Mow the lawn" => "monthly",
  "Take out the trash" => "weekly",
  "Clean the bathroom" => "weekly",
  "Do the laundry" => "daily",
  "Dust the furniture" => "weekly",
  "Organize the pantry" => "monthly",
  "Water the plants" => "daily",
  "Sweep the floors" => "weekly",
  "Clean the refrigerator" => "monthly",
  "Change bed linens" => "weekly",
  "Wipe down kitchen surfaces" => "daily",
  "Clean the windows" => "monthly",
  "Feed the pets" => "daily"
}
puts "creating users..."
max = User.create!({
  username: "max",
  email: "max@gmail.com",
  password: "maxmaxmax"
})

household = Household.create({ title: "ChoreQuest", user: max })

max.household = household
max.save

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

# puts "creating tasks..."
# task_titles.each do |k, v|
#   task = Task.create!({
#     category: Task::CATEGORIES.sample,
#     title: k,
#     description: Faker::Lorem.paragraph,
#     user: User.all.sample,
#     household: household,
#     frequency: v
#   })

#   Submission.create!({
#     status: rand(0..1),
#     task: task,
#     user: User.all.sample
#   })
# end


puts "finished seeding! :)"
