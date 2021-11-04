//
//  PostService.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct PostService {
    
  static func uploadPost(title: String, content: String, image: UIImage?, user: User, completion: @escaping(FirestoreCompletion)) {
    let uuid = NSUUID().uuidString

    if image == nil {
      let data = ["title": title,
                  "content": content,
                  "imageURL": "",
                  "commentCount": 0,
                  "timestamp": Timestamp(date: Date()),
                  "ownerUID": user.uid,
                  "uuid": uuid,
                  "ownerName": user.name
                  ] as [String: Any]
      COLLECTION_POSTS.document(uuid).setData(data, completion: completion)
    } else {
      guard let image = image else { return}

      ImageUploader.uploadPostImage(image: image, uuid: uuid) { imageURL in
        let data = ["title": title,
                    "content": content,
                    "imageURL": imageURL,
                    "commentCount": 0,
                    "timestamp": Timestamp(date: Date()),
                    "ownerUID": user.uid,
                    "uuid": uuid,
                    "ownerName": user.name
                    ] as [String: Any]
        COLLECTION_POSTS.document(uuid).setData(data, completion: completion)
      }
    }
  }
  
  static func updatePost(title: String, content: String, image: UIImage?, user: User, post: Post, completion: @escaping(FirestoreCompletion)) {

    if image == nil {
      let data = ["title": title,
                  "content": content,
                  "imageURL": post.imageURL,
                  "commentCount": 0,
                  "timestamp": Timestamp(date: Date()),
                  "ownerUID": user.uid,
                  "uuid": post.uuid,
                  "ownerName": user.name
                  ] as [String: Any]
      COLLECTION_POSTS.document(post.uuid).setData(data, completion: completion)
    } else {
      guard let image = image else { return}

      ImageUploader.uploadPostImage(image: image, uuid: post.uuid) { imageURL in
        let data = ["title": title,
                    "content": content,
                    "imageURL": imageURL,
                    "commentCount": 0,
                    "timestamp": Timestamp(date: Date()),
                    "ownerUID": user.uid,
                    "uuid": post.uuid,
                    "ownerName": user.name
                    ] as [String: Any]
        COLLECTION_POSTS.document(post.uuid).setData(data, completion: completion)
      }
    }
  }
  
  static func fetchPost(post: Post, completion: @escaping(Post) -> Void) {

    COLLECTION_POSTS.document(post.uuid).getDocument { snapshot, error in
      guard let dictionary = snapshot?.data() else { return }
      let post = Post(postID: post.postID, dictionary: dictionary)
      completion(post)
    }
  }
    
  static func fetchPosts(completion: @escaping([Post]) -> Void) {
    COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
      guard let documents = snapshot?.documents else { return }
      let posts = documents.map({ Post(postID: $0.documentID, dictionary: $0.data()) })
      completion(posts)
    }
  }
  
//  static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
//      let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
//
//      query.getDocuments { (snapshot, error) in
//          guard let documents = snapshot?.documents else { return }
//
//          var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())} )
//
//          posts.sort { (post1, post2) -> Bool in
//              return post1.timestamp.seconds > post2.timestamp.seconds
//          }
//
//          completion(posts)
//      }
//  }
}
