FactoryBot.define do
  factory :project do
    user
    user_id { user.id }
    name { "Projet de test" }
    description { "1000°C feat. Roméo Elvis
                  Ecrit par Lomepal et Roméo Elvis
                  Composé par Pierrick Devin, Superpoze, Vladimir Cauchemar, VM The Don"
                }
    amount { 1000 }
    client_email { user.email }
    client_first_name { user.first_name }
    client_last_name { user.last_name }
    url { "www.test_url.com" }
    message { "Message text pour le mail" }
  end
end
