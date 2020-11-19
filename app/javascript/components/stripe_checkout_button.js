const triggerStripeCheckout = () => {
  const paymentButton = document.getElementById('checkout-button');

  if (paymentButton) {
    paymentButton.addEventListener('click', () => {
      const stripe = Stripe(paymentButton.dataset.spk,
        {
          stripeAccount: paymentButton.dataset.uid,
        }
      );
      stripe.redirectToCheckout({
        sessionId: paymentButton.dataset.csid
      });
    });
  }
}

export { triggerStripeCheckout }
