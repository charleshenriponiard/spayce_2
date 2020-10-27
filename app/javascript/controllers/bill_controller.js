import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "spayceCommission", "promoCode", "billTax", "total" ]

  calculate(event) {

    const amount = event.target.value / 1
    const commission = amount * 0.1
    const taxes = commission * 0.2
    const total = amount - commission - taxes

    this.priceTarget.innerHTML = amount.toFixed(2)
    this.spayceCommissionTarget.innerHTML = commission.toFixed(2)
    this.billTaxTarget.innerHTML = taxes.toFixed(2)
    this.totalTarget.innerHTML = total.toFixed(2)
  }
}
