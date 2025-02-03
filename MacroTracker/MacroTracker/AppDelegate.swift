//
//  AppDelegate.swift
//  MacroTracker
//
//  Created by Brian Weaver on 11/20/24.
//

import HotwireNative
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Hotwire.loadPathConfiguration(from: [
      .file(Server.localPathConfigURL),
      .server(Server.remotePathConfigURL)
    ])
    
    let primaryColor: UIColor
    if let primaryColorHex = Hotwire.config.pathConfiguration.settings["primary_color"] as? String {
      primaryColor = UIColor(hex: primaryColorHex)
    } else {
      primaryColor = UIColor.systemBlue
    }
    UITabBar.appearance().tintColor = primaryColor
    UINavigationBar.appearance().tintColor = primaryColor
    
    Hotwire.config.debugLoggingEnabled = Hotwire.config.pathConfiguration.settings["debug"] as? Bool ?? false
    Hotwire.config.pathConfiguration.matchQueryStrings = false
    Hotwire.registerBridgeComponents(BridgeComponent.allTypes)
    
    // Set configuration options
    Hotwire.config.backButtonDisplayMode = .minimal
    Hotwire.config.showDoneButtonOnModals = true
#if DEBUG
    Hotwire.config.debugLoggingEnabled = true
#endif
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}
