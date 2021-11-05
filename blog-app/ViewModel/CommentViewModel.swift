//
//  CommentViewModel.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import UIKit

struct CommentViewModel {
  
  private let comment: Comment
  
  var name: String { return comment.name}

  var content: String { return comment.content }

  var timestamp: String {
    return "\(TimestampString.dateString(comment.timestamp)) 전"
  }
  
  init(comment: Comment) {
    self.comment = comment
  }

  func size(forWidth width: CGFloat) -> CGSize {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = comment.content
    label.lineBreakMode = .byWordWrapping
    label.setWidth(width)
    return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
  }
}
