FactoryBot.define do
  factory :company do
    user
    company_number { "765 654 566" }
    name { "Benoit Calin" }
    business_type { "Standard" }
    address_line1 { "8, cours de la martinique" }
    address_line2 { nil }
    postal_code { "33000" }
    city { "Bordeaux" }
    country { "France" }
    state { "Gironde" }
    phone_number { "0836656565" }
    structure { "auto-entreprise" }
    verification_status { true }
  end
end
