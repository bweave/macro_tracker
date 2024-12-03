import HotwireNative
import UIKit

let pathConfiguration = PathConfiguration(sources: [
  .file(Server.localPathConfigURL),
  .server(Server.remotePathConfigURL)
])

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  private var coordinator: TabCoordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    UINavigationBar.configureWithOpaqueBackground()
    
    Hotwire.config.debugLoggingEnabled = pathConfiguration.settings["debug"] as? Bool ?? false
    Hotwire.config.pathConfiguration.matchQueryStrings = false
    Hotwire.registerBridgeComponents(BridgeComponent.allTypes)
    
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    
    coordinator = TabCoordinator(window: window)
    coordinator?.start()
  }
}
