//
//  InputTextView.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit

class InputTextView: UITextView {
    
  // MARK: - Properties
    
  var placeholderText: String? {
    didSet { placeholderLabel.text = placeholderText }
  }
    
  let placeholderLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
    label.textColor = .lightGray
    return label
  }()
    
  var placeholderShouldCenter = true {
    didSet {
      if placeholderShouldCenter {
        placeholderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 5)
        placeholderLabel.centerY(inView: self)
      } else {
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 16)
      }
    }
  }
  
  // MARK: - Lifecycle

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
        
    addSubview(placeholderLabel)
        
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(handleTextDidChange),
      name: UITextView.textDidChangeNotification,
      object: nil
    )
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
  }
    
  // MARK: - Actions
    
  @objc func handleTextDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }
}
