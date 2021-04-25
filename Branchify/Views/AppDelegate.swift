//
//  AppDelegate.swift
//  Branchify
//
//  Created by Alexis Rojas-Westall on 4/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // deleted this from App delegate
//    SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate
    
    var window: UIWindow?

    var playURI = ""

    let SpotifyClientID = "8928f5c47fda48048c5238c94ab09650"
//    let SpotifyRedirectURL = URL(string: "https://Branchify-login://")!
    var accessToken = ""

//    lazy var configuration = SPTConfiguration(
//      clientID: SpotifyClientID,
//      redirectURL: SpotifyRedirectURL
//    )

    //initialize App Remote
//    lazy var appRemote: SPTAppRemote = {
//      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
//      appRemote.connectionParameters.accessToken = self.accessToken
//      appRemote.delegate = self
//      return appRemote
//    }()

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
//        window.makeKeyAndVisible()
//        self.window = window
        if AuthManager.shared.isSignedIn {
            window?.rootViewController = TabBarViewController()
        } else {
            let navvc = UINavigationController(rootViewController: WelcomeViewController())
            navvc.navigationBar.prefersLargeTitles = true
            navvc.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window?.rootViewController = navvc
        }
        
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = WelcomeViewController()
        window?.makeKeyAndVisible()
//        print(AuthManager.shared.signInURL?.absoluteString)
//      let parameters = appRemote.authorizationParameters(from: url);
//
//            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//                appRemote.connectionParameters.accessToken = access_token
//                self.accessToken = access_token
//            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//                // Show the error
//            }
      return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let window = UIWindow(frame: UIScreen.main.bounds)
////        window.rootViewController = WelcomeViewController()
//        window.makeKeyAndVisible()
//        self.window = window
//        if AuthManager.shared.isSignedIn {
//            window.rootViewController = TabBarViewController()
//        } else {
//            let navvc = UINavigationController(rootViewController: WelcomeViewController())
//            navvc.navigationBar.prefersLargeTitles = true
//            navvc.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
//            window.rootViewController = navvc
//        }
//
////        let window = UIWindow(frame: UIScreen.main.bounds)
////        window.rootViewController = WelcomeViewController()
//        window.makeKeyAndVisible()
//        self.window = window
        
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
    
    //needed to implement SPTAppRemoteDelegate and SPTAppRemotePlayerStateDelegate
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
////        self.appRemote.playerAPI?.delegate = self
////          self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
////            if let error = error {
////              debugPrint(error.localizedDescription)
////            }
////          })
////      print("connected")
//    }
    
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//      print("disconnected")
//    }
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//      print("failed")
//    }
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
////        debugPrint("Track name: %@", playerState.track.name)
//      print("player state changed")
//    }
//
    
//    func connect() {
//      self.appRemote.authorizeAndPlayURI(self.playURI)
//    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//      if self.appRemote.isConnected {
//        self.appRemote.disconnect()
//      }
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//      if let _ = self.appRemote.connectionParameters.accessToken {
//        self.appRemote.connect()
//      }
//    }

}

