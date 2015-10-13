require './models.rb'

User.create({
	:username => "tstarwalt",
	:fname => "Troy",
	:lname => "Starwalt",
	:email => "troy.starwalt@gmail.com",
	:password => "password"
})

User.create({
	:username => "norkick13",
	:fname => "Nor",
	:lname => "Singh",
	:email => "norvinder@gmail.com",
	:password => "password1"
})

User.create({
	:username => "chopper",
	:fname => "Cat",
	:lname => "Starwalt",
	:email => "chopper@gmail.com",
	:password => "password2"
})