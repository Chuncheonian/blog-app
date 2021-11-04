//
//  AuthService.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import UIKit
import Firebase

struct AuthService {
  
  static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }
  
//  static func registerUser(completion: @escaping(Error?) -> Void) {
//    Auth.auth().createUser(withEmail: "admin@gmail.com", password: "123456") { result, error in
//      guard let uid = result?.user.uid else { return }
//
//      let data: [String: Any] = ["email": "admin@gmail.com",
//                                   "name": "Dongyoung Kwon",
//                                   "profileImageURL": "",
//                                   "uid": uid]
//
//      Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
//    }
//  }
}
