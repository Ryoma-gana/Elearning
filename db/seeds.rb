# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(
    name: "Admin",
    email: "admin@gmail.com",
    password: "password",
    admin: true
)

50.times do |n|
    User.create!(
        name: Faker::Games::Pokemon.name,
        email: Faker::Internet.unique.email,
        password:"password"
    )
end

users=User.all
user=User.first
following=users[2..40]
followers=users[3..40]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}