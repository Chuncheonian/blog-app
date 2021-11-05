//
//  AppDelegate.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      let navigationBar = UINavigationBar()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255.0/255.0, alpha: 1.0)
      navigationBar.standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    FirebaseApp.configure()
    
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = false
    IQKeyboardManager.shared.enableAutoToolbar = true
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }


}

