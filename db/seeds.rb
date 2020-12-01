puts "Destroying everything"
Project.destroy_all
User.destroy_all
puts "Everything has been destroyed"

puts "Creating things"

puts "Creating Users and Projects"
carlito = User.new(
  email: 'c.poniard@gmail.com',
  first_name: "Charles-Henri",
  last_name: "Poniard",
  entity_name: 'Grosse SARL',
  siret: '123123123',
  address_line1: '8 cours de la Martinique',
  zipcode: '33000',
  city: 'Bordeaux',
  state: 'Gironde',
  country: "FR",
  password: 'secret',
  admin: true)
carlito.skip_confirmation!
carlito.save
3.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  carlito.projects.create!(
    name: Faker::Book.title,
    client_email: "#{ first_name }.#{ last_name }@gmail.com",
    client_first_name: first_name,
    client_last_name: last_name,
    description: Faker::Hipster.paragraph,
    amount: rand(100..1000),
    message: Faker::Lorem.paragraph
  )
end

benoit = User.new(
  email: 'benoit.calin@kedgebs.com',
  first_name: "Benoit",
  last_name: "Calin",
  entity_name: 'Grosse SARL',
  siret: '123123123',
  address_line1: '8 cours de la Martinique',
  zipcode: '33000',
  city: 'Bordeaux',
  state: 'Gironde',
  country: "FR",
  password: 'secret',
  admin: true)
benoit.skip_confirmation!
benoit.save

3.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  benoit.projects.create!(
    name: Faker::Book.title,
    client_email: "#{ first_name }.#{ last_name }@gmail.com",
    client_first_name: first_name,
    client_last_name: last_name,
    description: Faker::Hipster.paragraph,
    amount: rand(100..1000),
    message: Faker::Lorem.paragraph
  )
end
cedric = User.new(
  email: 'cedricsauvagetpro@gmail.com',
  first_name: "Cédric",
  last_name: "Sauvaget",
  entity_name: 'Grosse SARL',
  siret: '123123123',
  address_line1: '8 cours de la Martinique',
  zipcode: '33000',
  city: 'Bordeaux',
  state: 'Gironde',
  country: "FR",
  password: 'secret',
  admin: true)
cedric.skip_confirmation!
cedric.save
3.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  cedric.projects.create!(
    name: Faker::Book.title,
    client_email: "#{ first_name }.#{ last_name }@gmail.com",
    client_first_name: first_name,
    client_last_name: last_name,
    description: Faker::Hipster.paragraph,
    amount: rand(100..1000),
    message: Faker::Lorem.paragraph
  )
end
fanny = User.new(
  email: 'fanny@gmail.com',
  first_name: "Fanny",
  last_name: "Poniard",
  entity_name: 'Grosse SARL',
  siret: '123123123',
  address_line1: '8 cours de la Martinique',
  zipcode: '33000',
  city: 'Bordeaux',
  state: 'Gironde',
  country: "FR",
  password: 'secret')
fanny.skip_confirmation!
fanny.save
3.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  fanny.projects.create!(
    name: Faker::Book.title,
    client_email: "#{ first_name }.#{ last_name }@gmail.com",
    client_first_name: first_name,
    client_last_name: last_name,
    description: Faker::Hipster.paragraph,
    amount: rand(100..1000),
    message: Faker::Lorem.paragraph
  )
end
puts "Users and Projects creation finished"

puts "Clear all jobs in mailer queue"
queue = Sidekiq::Queue.new('mailer')
queue.clear

puts "Not creating companies, will do directly through Stripe"

puts "All things creation finished"

