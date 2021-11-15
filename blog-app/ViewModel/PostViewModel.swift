//
//  PostViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import Foundation

struct PostViewModel {
  let post: Post
    
  var title: String { return post.title }
  
  var content: String { return post.content }
  
  var imageURL: URL? { return URL(string: post.imageURL) }
  
  var commentCount: String { return "\(post.commentCount)개의 댓글" }
  
  var timestamp: String {
    return "\(TimestampString.dateString(post.timestamp)) 전"
  }
  
  init(post: Post) {
    self.post = post
  }
}

