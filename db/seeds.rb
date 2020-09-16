puts "Destroying everything"
Company.destroy_all
User.destroy_all
puts "Everything has been destroyed"

puts "Creating things"

puts "Creating Users"
carlito = User.new(email: 'c.poniard@gmail.com', password: 'secret', admin: true)
carlito.skip_confirmation!
carlito.save
benoit = User.new(email: 'benoit.calin@gmail.com', password: 'secret', admin: true)
benoit.skip_confirmation!
benoit.save
cedric = User.new(email: 'cedricsauvagetpro@gmail.com', password: 'secret', admin: true)
cedric.skip_confirmation!
cedric.save
fanny = User.new(email: 'fanny@gmail.com', password: 'secret')
fanny.skip_confirmation!
fanny.save
puts "Users creation finished"

puts "Clear all jobs in mailer queue"
queue = Sidekiq::Queue.new('mailer')
queue.clear

puts "Not creating companies, will do directly through Stripe"

puts "All things creation finished"

