FactoryBot.define do
  factory :project do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    user
    user_id { user.id }
    name { Faker::Book.title }
    description { Faker::Hipster.paragraph }
    amount { rand(100..1000)}
    client_email { "#{ first_name }.#{ last_name }@gmail.com"}
    client_first_name { first_name }
    client_last_name { last_name }
    message { Faker::Lorem.paragraph }
  end
end
