StripeEvent.signing_secret = ENV["STRIPE_WEBHOOK_KEY"]

StripeEvent.configure do |events|
  events.subscribe 'account.updated', Stripe::AccountUpdatedEventHandler.new
end
