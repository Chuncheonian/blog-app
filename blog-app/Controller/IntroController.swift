//
//  IntroController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

class IntroController: UIViewController {
  
  // MARK: - Properties
  private let introLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = "iOS 개발자를 꿈꾸는 학생입니다.\n새로운 기술을 학습하고, 직접 적용해보는 경험을 좋아해 많은 서비스들을 개발 / 배포 / 운영하고 있습니다.\n함께라는 가치를 중요시합니다. 혼자서는 하지 못 하는 일을 같은 지향점을 가진 동료들과 발전하고 싶습니다.\n\nMake It Count!!"
    label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    return label
  }()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(introLabel)
    introLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 22, paddingLeft: 16, paddingRight: 16)
  }
}
