//
//  IntroController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

class IntroController: UIViewController {
  
  // MARK: - Properties
  
  var viewModel: IntroViewModel? {
    didSet { updateUI() }
  }

  private lazy var introLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    return label
  }()
  
  
  // MARK: - Lifecycle
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(introLabel)
    introLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 22, paddingLeft: 16, paddingRight: 16)
  }
  
  fileprivate func updateUI() {
    introLabel.text = viewModel?.biography
  }
}
