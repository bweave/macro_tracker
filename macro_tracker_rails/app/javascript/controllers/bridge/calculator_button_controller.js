// NOTE: this is so dumb that I have to copy/past ButtonController because
// Hotwire Native components don't know how to handle multiple of the same
// component at once.

import { BridgeComponent } from "@hotwired/strada"
// import { Controller } from "@hotwired/stimulus"

export default class extends BridgeComponent {
  // export default class extends Controller {
  static component = "calculator"

  connect() {
    console.log("HERE")
    super.connect()
    this.#notifyBridgeOfConnect()
  }

  #notifyBridgeOfConnect() {
    const element = this.bridgeElement
    const title = element.title
    const image = element.bridgeAttribute("ios-image") || ""
    const side = element.bridgeAttribute("side") || "right"
    this.send("connect", { title, image, side }, () => {
      this.element.click()
    })
  }
}
