StripeEvent.signing_secret = ENV["STRIPE_WEBHOOK_KEY"]

Rails.configuration.to_prepare do
  StripeEvent.configure do |events|
    events.subscribe 'account.updated', Stripe::AccountUpdatedEventHandler.new
  end
end
