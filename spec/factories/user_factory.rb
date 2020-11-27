FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
    password { "secret" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    entity_name { Faker::Company.name }
    siret { Faker::Company.french_siret_number }
    address_line1 { Faker::Address.street_address }
    zipcode { Faker::Address.zip }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { ["US", "FR"].sample }
    trait :with_project do
      after :create do |user|
        create_list :project, 3, user: user
      end
    end
    before :create, &:confirm
  end
end
