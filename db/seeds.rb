# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Clearing db...'
Planet.destroy_all
Scientist.destroy_all
Mission.destroy_all

Faker::TvShows::StarTrek.unique.clear
Faker::Space.unique.clear
Faker::TvShows::Buffy.unique.clear

puts 'Making planets...'
20.times do
  Planet.create(
    name: Faker::TvShows::StarTrek.unique.location,
    distance_from_earth: Faker::Space.unique.distance_measurement,
    nearest_star: Faker::Space.star,
    image: "planet#{rand(1..10)}",
  )
end

puts 'Making scientists...'
15.times do
  Scientist.create(
    name: Faker::FunnyName.name,
    field_of_study: Faker::Educator.subject,
    avatar: Faker::Avatar.image(size: '200x200', set: 'set3'),
  )
end

puts 'Making missions...'
20.times do
  Mission.create(
    name: Faker::TvShows::Buffy.unique.episode,
    scientist_id: Scientist.ids.sample,
    planet_id: Planet.ids.sample,
  )
end

puts 'Done seeding!'
