//
//  ProfileViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit

struct ProfileViewModel {
    
  let user: User
    
  var name: String { return user.name }
    
  var profileImageURL: URL? { return URL(string: user.profileImageURL) }
    
  init(user: User) {
    self.user = user
  }
}
