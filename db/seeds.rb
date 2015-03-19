# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
Meetup.create(name: "disc golf", description: "get to gether and play some disc-golf", location: "Boston Commons")
Meetup.create(name: "Ruby to the max!", description: "geek out with ruby", location: "any place that has pizza and arcade games")

User.create(provider: "facebook", uid: "G6", username: "Josh", email: "josh@gmail.com", avatar_url: "fsfsa")
User.create(provider: "github", uid: "G7", username: "David", email: "david@gmail.com", avatar_url: "skljgal")
User.create(provider: "myspace", uid: "G8", username: "Elliot", email: "elliot@gmail.com", avatar_url: "dfalj")

# josh is a member of the disc-golf group and the ruby group
Membership.create(user_id: 1, meetup_id: 1)
Membership.create(user_id: 1, meetup_id: 2)
# david is a member of the ruby group
Membership.create(user_id: 2, meetup_id: 2)
# elliot is also a member of the ruby group
Membership.create(user_id: 3, meetup_id: 2)
