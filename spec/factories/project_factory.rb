FactoryBot.define do
  factory :project do
    user
    user_id { user.id }
    name { Faker::Book.title }
    description { Faker::Hipster.paragraph }
    amount { rand(100..1000)}
    client_email { user.email }
    client_first_name { user.first_name }
    client_last_name { user.last_name }
    url { Faker::Internet.url }
    message { Faker::Lorem.paragraph }
  end
end
