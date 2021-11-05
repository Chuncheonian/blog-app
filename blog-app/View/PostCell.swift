//
//  PostCell.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {
  
  // MARK: - Properties
  
  var viewModel: PostViewModel? {
    didSet { configure() }
  }
  
  private let image: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleToFill
    return iv
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    label.numberOfLines = 2
    return label
  }()
  
  private let contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Light", size: 12)
    label.numberOfLines = 2
    return label
  }()
  
  private let postTimeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
    label.textColor = .lightGray
    return label
  }()
  
  private let commentCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
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
    postTimeLabel.anchor(left: titleLabel.leftAnchor, bottom: bottomAnchor, paddingBottom: 10)
    
    addSubview(commentCountLabel)
    commentCountLabel.anchor(left: postTimeLabel.rightAnchor, bottom: postTimeLabel.bottomAnchor, paddingLeft: 13)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  func configure() {
    guard let viewModel = viewModel else { return }
    image.kf.setImage(with: viewModel.imageURL)
    titleLabel.text = viewModel.title
    contentLabel.text = viewModel.content
    postTimeLabel.text = viewModel.timestamp
    commentCountLabel.text = viewModel.commentCount
  }
  
}
