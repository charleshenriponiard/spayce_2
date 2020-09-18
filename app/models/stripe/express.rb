class Stripe::Express
  include ActiveModel::Model
  attr_accessor :uid, :url

  def sign_up(user)
    account = Stripe::Account.create({
      country: user.country,
      type: 'express',
      requested_capabilities: ['card_payments', 'transfers'],
    })
    self.uid = account.id
    account_links = Stripe::AccountLink.create({
      account: account["id"],
      refresh_url: "http://localhost:5000/",
      return_url: "http://localhost:5000/",
      type: 'account_onboarding'
    })
    self.url = account_links["url"]
    return object = {uid: uid}
  end
end
