# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
	email: "test@example.com",
	first_name: "Mark",
	last_name: "Smith",
	age: 22,
	password: "password",
	password_confirmation: "password"
	)

user_second = User.create(
	email: "foo@bar.com",
	first_name: "Bob",
	last_name: "Jones",
	age: 47,
	password: "password",
	password_confirmation: "password"
	)

(1..15).each do |i|
	Grade.create(
		name: "V#{i}",
		value: i,
		)
end

route = Route.create(
	name: "Slippery Crack",
	grade: Grade.first,
	owner: user,
	info: "Five hold sequence to a knee-bar"
	)

route_second = Route.create(
	name: "Holy Joker",
	grade: Grade.last,
	owner: user_second,
	info: "100-move warm-up sequence"
	)

project = Project.create(
	route: route,
	user: user
	)

project_second = Project.create(
	route: route,
	user: user_second
	)

comment = Comment.create(
	user: user,
	route: route,
	body: "This is such a good route"
	)

comment_second = Comment.create(
	user: user_second,
	route: route,
	body: "I fell off and broke my coccyx"
	)