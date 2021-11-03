//
//  IntroViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit

struct IntroViewModel {
    
  let user: User
    
  var biography: String { return user.biography }
    
  init(user: User) {
    self.user = user
  }
}
