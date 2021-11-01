//
//  UserService.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import Firebase

struct UserService {
  
  static func fetchUser(completion: @escaping(User) -> Void) {
    
    guard let uid = Auth.auth().currentUser?.uid else { return }

    Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
        guard let dictionary = snapshot?.data() else { return }
        let user = User(dictionary: dictionary)
        completion(user)
    }
}
}
