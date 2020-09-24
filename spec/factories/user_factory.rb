FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
    password { "secret" }
    first_name { "Prénom" }
    last_name { "Nom" }
    before :create, &:confirm
    after :create do |user|
      create_list :project, 3, user: user
    end
  end
end
