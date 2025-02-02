import HotwireNative
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var coordinator: TabCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }

    UINavigationBar.configureWithOpaqueBackground()

    let window = UIWindow(windowScene: windowScene)
    self.window = window

    coordinator = TabCoordinator(window: window)
    coordinator?.start()
  }
}
