# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when "development"
	User.create!(name:  "Admin Boy",
	             email: "admin@gmail.com",
	             password:              "password",
	             password_confirmation: "password",
	             activated: true,
	             activated_at: Time.zone.now,
	             admin: true)

	30.times do |u|
		User.create!(name:  "Mr. #{u}",
					 email: "doe#{u}@gmail.com",
					 password:              "password",
					 password_confirmation: "password",
					 activated: true,
	             	 activated_at: Time.zone.now)
	end

	Community.create!(name: "First Community",
					  description: "The first seed community",
					  leader: User.first.id,
					  membership_setting: "open")

	Community.create!(name: "Second Community",
					  description: "The first seed community",
					  leader: User.last.id,
					  membership_setting: "closed")

	Community.create!(name: "Delfy",
					  description: "Tutorial community",
					  leader: User.first.id,
					  membership_setting: "open")

	users = User.all
	users.each { |u| u.join(Community.first)}

	Idea.create!(community: Community.first,
				 user: User.first,
				 content: "Lorem grundle fish")

	110.times do |b|
		BranchIdea.create!(user: User.find_by(id: 1),
						   idea: Idea.first,
						   community: Community.first,
						   content: "Lorem grundle fish the #{b+3}th")
	end

	10.times do |v|
		Vote.create!(user: User.find_by(id: v+1),
					 idea: Idea.find_by(id: 1),
					 branch_idea: Idea.find_by(id: 1).branches.first,
					 community: Idea.find_by(id: 1).community)
	end

	10.times do |v|
		Vote.create!(user: User.find_by(id: v+11),
					 idea: Idea.find_by(id: 1),
					 branch_idea: Idea.find_by(id: 1).branches.second,
					 community: Idea.find_by(id: 1).community)
	end

	10.times do |v|
		Vote.create!(user: User.find_by(id: v+21),
					 idea: Idea.find_by(id: 1),
					 branch_idea: Idea.find_by(id: 1).branches.third,
					 community: Idea.find_by(id: 1).community)
	end

	110.times do |i|
		Idea.create!(community: Community.first,
					 user: User.first,
					 content: "Idea #{i+1}")
	end
when "production"
	User.create!(name:                  "Delfy Help",
				 email:                 "delfyhelp@gmail.com",
				 password:              "starterpw",
				 password_confirmation: "starterpw",
				 activated:             true,
				 activated_at:          Time.zone.now,
				 admin:                 true)

	Community.create!(name:               "Delfy",
					  description:        "This community is for gathering feedback 
					  					  on the Delfy platform from its users. Get a sense for 
					  					  how things work while helping us improve the platform!",
					  leader:             User.first.id,
					  membership_setting: "open")
end