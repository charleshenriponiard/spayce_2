class CreateCheckoutSessionJob < ApplicationJob
  queue_as :stripe

  def perform(project)
    # stripe_account = Stripe::Account.retrieve(project.user.uid)
    fees = project.amount * 10 / 100 * 1.2
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: project.name,
        amount: project.amount,
        currency: 'eur',
        quantity: 1
      }],
      payment_intent_data: {
        application_fee_amount: fees.to_i,
      },
      mode: 'payment',
      success_url: "http://localhost:5000/clients/projects/#{project.id}",
      cancel_url: "http://localhost:5000/clients/projects/#{project.id}",
      }, {stripe_account: project.user.uid})

    project.update(checkout_session_id: session.id, payment_intent_id: session.payment_intent)
  end
end
