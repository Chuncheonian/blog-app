//
//  CommentService.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import Firebase

struct CommentService {
  
  static func uploadComment(comment: String, post: Post, user: User, completion: @escaping(FirestoreCompletion)) {
    
    let name = user.isCurrentUser ? "작성자" : "익명"
    
    let commentData: [String: Any] = [
      "uid": user.uid,
      "content": comment,
      "timestamp": Timestamp(date: Date()),
      "name": name
    ]
          
    COLLECTION_POSTS.document(post.uuid).collection("comments").addDocument(data: commentData, completion: completion)
    
    let postData = ["title": post.title,
                    "content": post.content,
                    "imageURL": post.imageURL,
                    "commentCount": post.commentCount + 1,
                    "timestamp": post.timestamp,
                    "ownerUID": user.uid,
                    "uuid": post.uuid,
                    "ownerName": user.name
                    ] as [String: Any]
    COLLECTION_POSTS.document(post.uuid).setData(postData, completion: completion)
  }
      
  static func fetchComments(forPost post: Post, completion: @escaping([Comment]) -> Void) {
    var comments = [Comment]()
    let query = COLLECTION_POSTS.document(post.uuid).collection("comments").order(by: "timestamp", descending: true)
          
    query.addSnapshotListener { snapshot, error in
      snapshot?.documentChanges.forEach({ change in
        if change.type == .added {
          let data = change.document.data()
          let comment = Comment(dictionary: data)
          comments.append(comment)
        }
      })
      completion(comments)
    }
  }
}

