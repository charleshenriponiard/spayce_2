StripeEvent.signing_secret = ENV["STRIPE_WEBHOOK_KEY"]

StripeEvent.configure do |events|
  events.all, Stripe::InvoiceEventHandler.new
end
