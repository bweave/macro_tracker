import { Controller } from "@hotwired/stimulus"

function debounce(callback, delay) {
  let timeout

  return (...args) => {
    clearTimeout(timeout)

    timeout = setTimeout(() => {
      callback.apply(this, args)
    }, delay)
  }
}

// Connects to data-controller="goals"
export default class extends Controller {
  static values = {
    delay: {
      type: Number,
      default: 500,
    },
  }

  initialize() {
    this.submit = this.submit.bind(this)
  }

  connect() {
    if (this.delayValue > 0) {
      this.submit = debounce(this.submit, this.delayValue)
    }
  }

  submit() {
    this.element.requestSubmit()
  }
}
