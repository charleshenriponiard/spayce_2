const triggerStripeCheckout = () => {
  const paymentButton = document.getElementById('checkout-button');

  if (paymentButton) {
    paymentButton.addEventListener('click', () => {
      checkoutStripe(paymentButton)
    });
  }
}

const sendData = (paymentButton, project) => {
  const stripe = Stripe(paymentButton.dataset.spk,
    {
      stripeAccount: paymentButton.dataset.uid,
    }
  );
  stripe.redirectToCheckout({
    sessionId: project.data.checkout_session_id
  });
}

const checkoutStripe = (paymentButton) => {
  const baseURI = window.location.href
  fetch(`${baseURI}/create_checkout_session`)
    .then(response => response.json())
    .then(project => {
      sendData(paymentButton, project)
    })
    .catch(error => console.log(error, 'ERROR'))
}


export { triggerStripeCheckout }
