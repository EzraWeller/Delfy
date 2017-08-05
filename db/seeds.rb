# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Admin Boy",
             email: "admin@gmail.com",
             password:              "password",
             password_confirmation: "password")

Community.create!(name: "Baltimore City",
	              description: "County in Maryland, USA",
	              leader: 1)

3.times do |n|
	Idea.create!(user_id: 1,
	             community_id: 1,
	             content: "It's post number #{n+1}!",
	             created_at: (0+n).days.ago)
end