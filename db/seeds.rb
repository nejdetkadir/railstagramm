# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

progress_bar = ProgressBar.create(:title => "Seed data", :starting_at => 0, :total => 10)

Gender.create(name: "Male")
Gender.create(name: "Female")
Gender.create(name: "Prefer Not To Say")

10.times do |user|
  progress_bar&.increment
  User.create(
    email: Faker::Internet.email,
    password: "123456789",
    password_confirmation: "123456789",
    fullname: Faker::Name.name_with_middle,
    username: Faker::Name.first_name.downcase,
    bio: Faker::Lorem.sentence,
    website: Faker::Internet.url,
    remote_profile_url: Faker::Avatar.image,
    gender_id: Gender.first.id,
    birthday: Faker::Date.between(from: 20.years.ago, to: Date.today)
  )
  
  4.times do |post|
    Post.create(
      remote_image_url: Faker::LoremFlickr.image(size: "1000x1000"),
      description: Faker::Lorem.sentence,
      user_id: User.last.id
    )
  end
end