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
    const commission = amount * -0.1
    const taxes = commission * 0.2
    const total = amount + commission + taxes
    const locale = window.location.pathname.includes('/en') ? 'en-US' : 'fr-FR'
    const currency = window.location.pathname.includes('/en') ? 'USD' : 'EUR'

    this.priceTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(amount.toFixed(2))
    this.spayceCommissionTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(commission.toFixed(2))
    this.billTaxTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(taxes.toFixed(2))
    this.totalTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(total.toFixed(2))
  }
}
