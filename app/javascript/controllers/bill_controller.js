import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "spayceCommission", "promoCode", "billTax", "total", "amount" ]

  connect() {
    if(this.hasAmountTarget) {
      this.calculate(this.amountTarget.dataset.amount)
    }
  }

  createBill(event) {
    this.calculate(event.target.value)
  }

  calculate(element) {
    const amount = element / 1
    const commission = amount * 0.1
    const taxes = commission * 0.2
    const total = amount - commission - taxes

    this.priceTarget.innerHTML = amount.toFixed(2)
    this.spayceCommissionTarget.innerHTML = commission.toFixed(2)
    this.billTaxTarget.innerHTML = taxes.toFixed(2)
    this.totalTarget.innerHTML = total.toFixed(2)
  }
}
