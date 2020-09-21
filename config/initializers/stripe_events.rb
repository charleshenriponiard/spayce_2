StripeEvent.signing_secret = ENV["STRIPE_WEBHOOK_KEY"]

StripeEvent.configure do |events|
  events.subscribe 'account.', Stripe::OnboardingEventHandler.new
end