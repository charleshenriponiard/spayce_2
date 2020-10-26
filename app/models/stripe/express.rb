class Stripe::Express
  include ActiveModel::Model
  attr_accessor :uid, :url, :dashboard_url

  def sign_up(user)
    account = Stripe::Account.create({
      country: user.country,
      type: 'express',
      requested_capabilities: ['card_payments', 'transfers']
    })
    self.uid = account.id
    account_links = Stripe::AccountLink.create({
      account: account["id"],
      refresh_url: ENV['BASE_URL'],
      return_url: ENV['BASE_URL'],
      type: 'account_onboarding'
    })
    self.url = account_links["url"]
    return { uid: uid }
  end

  def onboarding(user)
    answer_request = Stripe::Account.create_login_link(user.uid)
    self.dashboard_url = answer_request["url"]
  end
end
