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

grade = Grade.create(
	name: "V1",
	value: 1,
	)

route = Route.create(
	name: "Slippery Crack",
	grade: grade
	)

project = Project.create(
	route: route,
	user: user
	)