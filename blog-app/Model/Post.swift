//
//  Post.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import Firebase

struct Post {
  var title: String
  var content: String
  var imageURL: String
  var commentCount: Int
  let ownerUID: String
  let uuid: String
  var timestamp: Timestamp
  let postID: String
  let ownerName: String
    
  init(postID: String, dictionary: [String: Any]) {
    self.postID = postID
    self.title = dictionary["title"] as? String ?? ""
    self.content = dictionary["content"] as? String ?? ""
    self.imageURL = dictionary["imageURL"] as? String ?? ""
    self.commentCount = dictionary["commentCount"] as? Int ?? 0
    self.ownerUID = dictionary["ownerUID"] as? String ?? ""
    self.uuid = dictionary["uuid"] as? String ?? ""
    self.ownerName = dictionary["ownerName"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
  }
}
