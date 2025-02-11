import UIKit
import HotwireNative

protocol Coordinator: AnyObject {
  func start()
}

class TabCoordinator: NSObject, Coordinator {
  private let window: UIWindow
  private let tabBarController: UITabBarController
  private var tabNavigators: [Navigator] = []
  private var tabPaths: [String] = []
  private var loadedTabs: Set<Int> = [0]
  private var tabs: [TabItem] = []
  
  init(window: UIWindow) {
    self.window = window
    self.tabBarController = UITabBarController()
    super.init()
    
    tabBarController.delegate = self
  }
  
  func start() {
    setupTabs()
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    
    // Load first tab
    if let firstPath = tabPaths.first {
      let firstURL = Server.rootURL.appending(path: firstPath)
      tabNavigators[0].route(firstURL)
    }
  }
  
  private func setupTabs() {
    UITabBar.configureWithOpaqueBackground(tabBarController: tabBarController)
    
    let tabDictionaries = Hotwire.config.pathConfiguration.settings["tabs"] as! [[String: String]]
    tabs = tabDictionaries.map(TabItem.init)
    
    var viewControllers: [UIViewController] = []
    
    for tab in tabs {
      let tabNavigator = Navigator()
      let tabViewController = tabNavigator.rootViewController
      tabViewController.tabBarItem = UITabBarItem(
        title: tab.title,
        image: UIImage(systemName: tab.image),
        selectedImage: UIImage(systemName: tab.selectedImage)
      )
      
      tabNavigators.append(tabNavigator)
      tabPaths.append(tab.path)
      viewControllers.append(tabViewController)
    }
    
    tabBarController.viewControllers = viewControllers
  }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let selectedIndex = tabBarController.selectedIndex
    
    if !loadedTabs.contains(selectedIndex) {
      let path = tabPaths[selectedIndex]
      let url = Server.rootURL.appending(path: path)
      tabNavigators[selectedIndex].route(url)
      loadedTabs.insert(selectedIndex)
    }
  }
}
