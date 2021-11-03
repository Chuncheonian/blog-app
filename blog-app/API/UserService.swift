//
//  UserService.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import Firebase

struct UserService {
  
  static func fetchUser(completion: @escaping(User) -> Void) {
    
    Firestore.firestore().collection("users").document("shR9jVbX5vdN6RDAJ8CchdJwfko2").getDocument { snapshot, error in
      guard let dictionary = snapshot?.data() else { return }
      let user = User(dictionary: dictionary)
      completion(user)
    }
  }
}
