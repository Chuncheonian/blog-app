//
//  Profile.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit

class Profile: UIView {
  
  // MARK: - Properties
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.image = UIImage(named: "venom-7")
    return iv
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Cera Pro Bold", size: 22)
    label.text = "Dongyoung Kwon"
    return label
  }()
  
  private lazy var githubButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(UIImage(named: "GitHub"), for: .normal)
    btn.tintColor = .systemGray
    btn.addTarget(self, action: #selector(handleGithub), for: .touchUpInside)
    return btn
  }()
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 13, paddingLeft: 33)
    profileImageView.setDimensions(height: 70, width: 70)
    profileImageView.layer.cornerRadius = 70 / 2
        
    let infoStack = UIStackView(arrangedSubviews: [nameLabel, githubButton])
    infoStack.axis = .vertical
    infoStack.alignment = .leading
    infoStack.spacing = 14
    
    addSubview(infoStack)
    infoStack.centerY(inView: profileImageView)
    infoStack.anchor(left: profileImageView.rightAnchor, paddingLeft: 12)
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Actions
  
  @objc func handleGithub() {
    print("DEBUG: Clicked Github Button.")
  }
  
  
}
