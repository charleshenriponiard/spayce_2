module Stripe
  class CheckoutSessionCreator < ApplicationService
    def initialize(project)
      @project = project
    end

    def call
      fees = @project.amount_cents * 0.05
      taxes = fees * 0.2
      stripe_fees = (@project.amount_cents * 1.4 / 100) + 25
      discount = fees * @project.discount

      fees_after_stripe = fees + taxes - stripe_fees - discount
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          name: @project.name,
          amount: @project.amount_cents,
          currency: 'eur',
          quantity: 1
        }],
        payment_intent_data: {
          application_fee_amount: fees_after_stripe.to_i,
        },
        mode: 'payment',
        success_url: "#{ENV['BASE_URL']}clients/projects/#{@project.slug}",
        cancel_url: "#{ENV['BASE_URL']}clients/projects/#{@project.slug}"
        }, { stripe_account: @project.user.uid })
      @project.update(
        checkout_session_id: session.id,
        payment_intent_id: session.payment_intent
      )
    end
  end
end
