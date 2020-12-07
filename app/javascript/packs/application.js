// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap"
import "controllers"
import { triggerStripeCheckout } from "../components/stripe_checkout_button"
import { copyToClipboard } from "components/clipboard"
import { triggerTooltips } from "../components/trigger_tooltips"
import { initProjectCable } from "../channels/project_channel"
import authActive from "../components/auth_active_class"
import { navbarActive } from "../components/navbar_active"
import { initSwal } from "../components/swal"

document.addEventListener('turbolinks:load', () => {
  triggerStripeCheckout();
  copyToClipboard();
  triggerTooltips();
  authActive();
  initProjectCable();
  navbarActive();
  initSwal();
});
