//
//  Profile.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit

class ProfileView: UIView {
  
  // MARK: - Properties
  
  var viewModel: ProfileViewModel? {
    didSet { updateUI() }
  }
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Cera Pro Bold", size: 22)
    return label
  }()
  
  private lazy var githubButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(UIImage(named: "GitHub"), for: .normal)
    btn.tintColor = .systemGray
    btn.addTarget(self, action: #selector(handleSocialBtn), for: .touchUpInside)
    return btn
  }()
  
  private lazy var facebookButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(UIImage(named: "Facebook"), for: .normal)
    btn.tintColor = .systemGray
    btn.addTarget(self, action: #selector(handleSocialBtn), for: .touchUpInside)
    return btn
  }()
  
  private lazy var instaButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(UIImage(named: "Instagram"), for: .normal)
    btn.tintColor = .systemGray
    btn.addTarget(self, action: #selector(handleSocialBtn), for: .touchUpInside)
    return btn
  }()
  
  private lazy var emailButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(UIImage(named: "Email"), for: .normal)
    btn.tintColor = .systemGray
    btn.addTarget(self, action: #selector(handleSocialBtn), for: .touchUpInside)
    return btn
  }()
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Actions
  
  @objc func handleSocialBtn() {
    print("DEBUG: Clicked Social Button.")
  }
  
  // MARK: - Helpers
  
  fileprivate func configure() {
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 13, paddingLeft: 33)
    profileImageView.setDimensions(height: 70, width: 70)
    profileImageView.layer.cornerRadius = 70 / 2
    
    addSubview(nameLabel)
    nameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingTop: 16, paddingLeft: 12)
    
    let socialBtnStack = UIStackView(arrangedSubviews: [githubButton, facebookButton, instaButton, emailButton])
    socialBtnStack.axis = .horizontal
    socialBtnStack.spacing = 12
    addSubview(socialBtnStack)
    socialBtnStack.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: 14, paddingLeft: 12)
  }
  
  fileprivate func updateUI() {
    guard let viewModel = viewModel else { return }
    profileImageView.kf.setImage(with: viewModel.profileImageURL)
    nameLabel.text = viewModel.name
  }
}
