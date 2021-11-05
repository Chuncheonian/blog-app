//
//  CommentCell.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
  // MARK: - Properties

  var viewModel: CommentViewModel? {
    didSet { configure() }
  }
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Cera Pro Bold", size: 15)
    return label
  }()
  
  private let timestampLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 11)
    label.textColor = .lightGray
    return label
  }()
  
  private let contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    label.numberOfLines = 0
    return label
  }()
  

  // MARK: - Lifecycle
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(nameLabel)
    nameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)
    
    addSubview(timestampLabel)
    timestampLabel.anchor(top: nameLabel.topAnchor, right: rightAnchor, paddingRight: 10)
    
    addSubview(contentLabel)
    contentLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor,
                           right: rightAnchor, paddingTop: 5, paddingRight: 10)
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  func configure() {
    guard let viewModel = viewModel else { return }
    nameLabel.text = viewModel.name
    timestampLabel.text = viewModel.timestamp
    contentLabel.text = viewModel.content
  }
}
