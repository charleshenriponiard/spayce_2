FactoryBot.define do
  factory :user do
    email { "factory_generated_user@gmail.com" }
    password { "secret" }
  end
end
