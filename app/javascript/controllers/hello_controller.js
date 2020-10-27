import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  calculate() {
    this.outputTarget.textContent = 'Hello, Stimulus!'
  }
}
