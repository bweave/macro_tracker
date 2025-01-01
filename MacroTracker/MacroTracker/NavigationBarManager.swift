import UIKit

class NavigationBarManager {
    static let shared = NavigationBarManager()
    
    private var rightBarButtonItems: [UIBarButtonItem] = []
    
    private init() {}
    
    func addRightBarButtonItem(_ item: UIBarButtonItem, to viewController: UIViewController) {
        rightBarButtonItems.append(item)
        let itemGroup = UIBarButtonItemGroup(barButtonItems: rightBarButtonItems, representativeItem: nil)
        viewController.navigationItem.rightBarButtonItems = itemGroup.barButtonItems
    }
}