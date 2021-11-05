//
//  Profile.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit
import Kingfisher

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
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // MARK: - Helpers
  
  fileprivate func configure() {
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 13, paddingLeft: 33)
    profileImageView.setDimensions(height: 70, width: 70)
    profileImageView.layer.cornerRadius = 70 / 2
    
    addSubview(nameLabel)
    nameLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
  }
  
  fileprivate func updateUI() {
    guard let viewModel = viewModel else { return }
    profileImageView.kf.setImage(with: viewModel.profileImageURL)
    nameLabel.text = viewModel.name
  }
}
