# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
	email: "test@example.com",
	password: "password",
	password_confirmation: "password"
	)

(1..15).each do |i|
	Grade.create(
		name: "V#{i}",
		value: i,
		)

route = Route.create(
	name: "Slippery Crack",
	grade: Grade.first
	)

project = Project.create(
	route: route,
	user: user
	)

comment = Comment.create(
	user: user,
	route: route,
	body: "This is such a good route"
	)