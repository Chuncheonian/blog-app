//
//  Comment.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import Firebase

struct Comment {
  let uid: String
  let name: String
  let timestamp: Timestamp
  let content: String
  
  init(dictionary: [String: Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.name = dictionary["name"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    self.content = dictionary["content"] as? String ?? ""
  }
  
}

