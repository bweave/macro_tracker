import UIKit

extension UITabBar {
  static func configureWithOpaqueBackground(tabBarController: UITabBarController) {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    tabBarController.tabBar.standardAppearance = appearance
    if #available(iOS 15.0, *) {
      tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
  }
}
