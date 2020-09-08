FactoryBot.define do
  factory :company do
    user { nil }
    company_number { "MyString" }
    name { "MyString" }
    business_type { "MyString" }
    address_line1 { "MyString" }
    address_line2 { "MyString" }
    postal_code { "MyString" }
    city { "MyString" }
    country { "MyString" }
    state { "MyString" }
    phone_number { "MyString" }
    structure { "MyString" }
    verification_status { "MyString" }
  end
end
