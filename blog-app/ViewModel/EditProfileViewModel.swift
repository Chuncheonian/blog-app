//
//  EditProfileViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import UIKit

struct EditProfileViewModel {
    
  let user: User
    
  var profileImageURL: URL? { return URL(string: user.profileImageURL) }
  var name: String { return user.name }
  var biography: String { return user.biography }
  
  var biographyCount: String {
    return "\(biography.count)/1000"
  }
  
  init(user: User) {
    self.user = user
  }
}

