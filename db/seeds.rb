puts "Destroying everything"
User.destroy_all
puts "Everything has been destroyed"

puts "Creating things"

puts "Creating Users"
carlito = User.create(email: 'c.poniard@gmail.com', password: 'secret', admin: true)
benoit = User.create(email: 'benoit.calin@gmail.com', password: 'secret', admin: true)
cedric = User.create(email: 'cedric@gmail.com', password: 'secret', admin: true)
fanny = User.create(email: 'fanny@gmail.com', password: 'secret')
puts "Users creation finished"


puts "All things creation finished"

