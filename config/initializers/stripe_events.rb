StripeEvent.signing_secret = ENV["STRIPE_WEBHOOK_KEY"]

StripeEvent.configure do |events|
  events.subscribe 'account.', Stripe::InvoiceEventHandler.new
  events.subscribe 'capability.', Stripe::InvoiceEventHandler.new
  events.subscribe 'person.', Stripe::InvoiceEventHandler.new
end
