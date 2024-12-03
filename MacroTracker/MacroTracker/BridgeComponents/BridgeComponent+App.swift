import HotwireNative

extension BridgeComponent {
  static var allTypes: [BridgeComponent.Type] {
    [
      ButtonComponent.self,
      CalculatorButtonComponent.self,
      FormComponent.self,
      MenuComponent.self,
    ]
  }
}