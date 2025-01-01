import Foundation

enum Server {
  static var rootURL: URL {
    #if DEBUG
    return URL(string: "http://localhost:3000")!
    #elseif STAGING
    return URL(string: "http://192.168.1.97:3000")!
    #else
    // return URL(string: "https://macrotrack.ing")!
    return URL(string: "https://macrotracker.bweave.dev")!
    #endif
  }
  
  static var remotePathConfigURL: URL {
    rootURL.appending(path: "/configurations/ios")
  }
  
  static var localPathConfigURL: URL {
    Bundle.main.url(forResource: "path-configuration", withExtension: "json")!
  }
}
