//
//  EditPostViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import UIKit

struct EditPostViewModel {
    
  let user: User
  let post: Post
    
  var imageURL: URL? { return URL(string: post.imageURL) }
  var title: String { return post.title }
  var content: String { return post.content }
    
  init(user: User, post: Post) {
    self.user = user
    self.post = post
  }
}


