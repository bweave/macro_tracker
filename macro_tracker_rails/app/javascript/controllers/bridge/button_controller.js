import { BridgeComponent } from "@hotwired/strada"

export default class extends BridgeComponent {
  static component = "button"

  connect() {
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
