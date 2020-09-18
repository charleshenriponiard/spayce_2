class Stripe::Express
  include ActiveModel::Model
  attr_accessor :uid, :url, :dashboard_url

  def sign_up(user)
    account = Stripe::Account.create({
      country: user.country,
      type: 'express',
      requested_capabilities: ['card_payments', 'transfers'],
    })
    self.uid = account.id
    account_links = Stripe::AccountLink.create({
      account: account["id"],
      refresh_url: ENV['STRIPE_URL_REFRESH'],
      return_url: ENV['STRIPE_URL_RETURN'],
      type: 'account_onboarding'
    })
    self.url = account_links["url"]
    return object = {uid: uid}
  end

  def dashboard_connect(user)
    answer_request = Stripe::Account.create_login_link(user.uid)
    self.dashboard_url = answer_request["url"]
  end

  def find_account(uid)
    Stripe::Account.retrieve(uid)
  end

end
