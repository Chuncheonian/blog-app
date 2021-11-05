//
//  SceneDelegate.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    
    // Login 가정
    AuthService.logUserIn(withEmail: "admin@gmail.com", password: "123456") { result, error in
      if let error = error {
        print("DEBUG: Failed to log user in \(error.localizedDescription)")
        return
      }
      UserService.fetchUser { user in
        self.window?.rootViewController = UINavigationController(rootViewController: MainController(user: user))
        self.window?.makeKeyAndVisible()
      }
    }
    
//    Login 가정없는 정상적인 방법
//    UserService.fetchUser { user in
//      self.window?.rootViewController = UINavigationController(rootViewController: MainController(user: user))
//      self.window?.makeKeyAndVisible()
//    }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}

}
