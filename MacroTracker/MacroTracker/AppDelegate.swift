//
//  AppDelegate.swift
//  MacroTracker
//
//  Created by Brian Weaver on 11/20/24.
//

import HotwireNative
import UIKit
import WebKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Hotwire.loadPathConfiguration(from: [
      .file(Server.localPathConfigURL),
      .server(Server.remotePathConfigURL)
    ])
    
    Hotwire.config.debugLoggingEnabled = Hotwire.config.pathConfiguration.settings["debug"] as? Bool ?? false
    Hotwire.config.pathConfiguration.matchQueryStrings = false
    Hotwire.registerBridgeComponents(BridgeComponent.allTypes)
    
    // Set configuration options
    Hotwire.config.backButtonDisplayMode = .minimal
    Hotwire.config.makeCustomWebView = { config in
      let webView = WKWebView(frame: .zero, configuration: config)
      webView.allowsLinkPreview = false
      return webView
    }
#if DEBUG
    Hotwire.config.debugLoggingEnabled = true
#endif
    
    configureAppearance()
    
    return true
  }
  
  // MARK: Appearance
  
  private func configureAppearance() {
    let primaryColor: UIColor
    if let primaryColorHex = Hotwire.config.pathConfiguration.settings["primary_color"] as? String {
      primaryColor = UIColor(hex: primaryColorHex)
    } else {
      primaryColor = .systemBackground
    }

    configureNavBarAppearance(primaryColor: primaryColor)
    configureTabBarAppearance(primaryColor: primaryColor)
  }
  
  @available(iOS 13.0, *)
  func configureNavBarAppearance(primaryColor: UIColor) {
    let customNavBarAppearance = UINavigationBarAppearance()
    
    // Apply primaryColor background.
    customNavBarAppearance.configureWithOpaqueBackground()
    customNavBarAppearance.backgroundColor = primaryColor
    
    // Apply white colored normal and large titles.
    customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    
    // Apply white color to all the nav bar buttons.
    let barButtonItemAppearance = UIBarButtonItemAppearance()
    barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
    barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
    barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    customNavBarAppearance.buttonAppearance = barButtonItemAppearance
    customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
    customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
    
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().standardAppearance = customNavBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = customNavBarAppearance
    UINavigationBar.appearance().compactAppearance = customNavBarAppearance
    UINavigationBar.appearance().compactScrollEdgeAppearance = customNavBarAppearance
  }
  
  func configureTabBarAppearance(primaryColor: UIColor) {
    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithOpaqueBackground()
    tabBarAppearance.backgroundColor = .systemBackground
    
    UITabBar.appearance().standardAppearance = tabBarAppearance
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    
    // Set the tint color for selected icons
    UITabBar.appearance().tintColor = primaryColor
    
    // Set the tint color for unselected icons
    UITabBar.appearance().unselectedItemTintColor = .lightGray
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
