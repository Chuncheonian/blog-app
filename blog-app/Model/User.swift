//
//  User.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import Foundation
import Firebase

struct User {
  
  let email: String
  let name: String
  let biography: String
  let profileImageURL: String
  let uid: String
    
  var isCurrentUser: Bool {
    return Auth.auth().currentUser?.uid == self.uid
  }
    
  init(dictionary: [String: Any]) {
    self.email = dictionary["email"] as? String ?? ""
    self.name = dictionary["name"] as? String ?? ""
    self.biography = dictionary["biography"] as? String ?? ""
    self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
  }
}
