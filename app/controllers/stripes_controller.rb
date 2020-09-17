class StripesController < ApplicationController

  def sign_up
    @account = Stripe::Account.create({
      country: 'FR',
      type: 'express',
      requested_capabilities: ['card_payments', 'transfers'],
    })
    account_links = Stripe::AccountLink.create({
      account: @account["id"],
      refresh_url: 'http://localhost:5000',
      return_url: 'http://localhost:5000',
      type: 'account_onboarding',
    })
    byebug
  end
end
