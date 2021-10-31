//
//  PagingMenuCell.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit
import PagingKit

class PagingMenuCell: PagingMenuViewCell {
  
  // MARK: - Properties
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 13)
    return label
  }()
  
  override public var isSelected: Bool {
    didSet {
      if isSelected { titleLabel.textColor = .black }
      else { titleLabel.textColor = .systemGray }
    }
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(titleLabel)
    titleLabel.centerY(inView: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
