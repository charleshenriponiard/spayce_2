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
      refresh_url: "https://spayce2-staging.herokuapp.com/",
      return_url: "https://spayce2-staging.herokuapp.com/",
      type: 'account_onboarding'
    })
    self.url = account_links["url"]
    return object = {uid: uid}
  end
end
