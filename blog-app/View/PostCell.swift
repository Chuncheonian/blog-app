//
//  PostCell.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

class PostCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let image: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "venom-7")
    iv.contentMode = .scaleToFill
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    label.numberOfLines = 2
    label.text = "[Swift] 스위프트 언어의 특징과 이에 대한 사견"
    return label
  }()
  
  private let contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Light", size: 12)
    label.numberOfLines = 2
    label.text = "Xcode 13.2 베타 부터 지원한다고 합니다! Swift Concurrency를 한번 알아볼까요."
    return label
  }()
  
  private let postTimeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
    label.text = "2 days ago"
    label.textColor = .lightGray
    return label
  }()
  
  private let commentCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
    label.text = "4개의 댓글"
    label.textColor = .lightGray
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  
    addSubview(image)
    image.anchor(top: topAnchor, right: rightAnchor, paddingTop: 16, paddingRight: 18)
    image.setDimensions(height: 85, width: 85)
    
    addSubview(titleLabel)
    titleLabel.anchor(top: topAnchor, left: leftAnchor, right: image.leftAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 10)
    
    addSubview(contentLabel)
    contentLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 5)
    
    addSubview(postTimeLabel)
    postTimeLabel.anchor(left: titleLabel.leftAnchor, bottom: bottomAnchor, paddingBottom: 15)
    
    addSubview(commentCountLabel)
    commentCountLabel.anchor(left: postTimeLabel.rightAnchor, bottom: postTimeLabel.bottomAnchor, paddingLeft: 13)
    
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
