import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "spayceCommission", "promoCode", "billTax", "total", "amount", "coupon" ]

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

    if (this.hasCouponTarget) {
      const discount = this.couponTarget.dataset.discount / 100
      const discountCommission = commission * (1 - discount)
      const discountTaxes = discountCommission * 0.2
      const discountTotal = amount + discountCommission + discountTaxes

      this.spayceCommissionTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(discountCommission.toFixed(2))
      this.billTaxTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(discountTaxes.toFixed(2))
      this.totalTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(discountTotal.toFixed(2))
    } else {
      this.spayceCommissionTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(commission.toFixed(2))
      this.billTaxTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(taxes.toFixed(2))
      this.totalTarget.innerHTML = new Intl.NumberFormat(locale, { style: 'currency', currency: currency }).format(total.toFixed(2))
    }
  }
}
