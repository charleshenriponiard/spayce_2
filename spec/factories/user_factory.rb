FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
    password { "secret" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    trait :with_project do
      after :create do |user|
        create_list :project, 3, user: user
      end
    end
    before :create, &:confirm
  end
end
