# FactoryBot.define do
#   factory :user do
#     email { "factory_generated_user@gmail.com" }
#     password { "secret" }
#   end
# end
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
    password { "secret" }
    after :create, &:confirm
  end
end
