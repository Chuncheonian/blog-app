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
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    label.text = "[Swift] 스위프트 언어의 특징과 이에 대한 사견"
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
//    backgroundColor = .yellow
    addSubview(image)
    image.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5)
    image.fillSuperview()
    image.setDimensions(height: 85, width: 85)
    
//    addSubview(titleLabel)
//    titleLabel.anchor(top: topAnchor, left: leftAnchor, )
    
    
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
