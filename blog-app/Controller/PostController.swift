//
//  PostController.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit
import Kingfisher

class PostController: UIViewController {
  
  // MARK: - Properties
  
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  private var post: Post
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Cera Pro Bold", size: 22)
    return label
  }()
  
  private let postTimeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "NotoSansKR-Light", size: 12)
    label.textColor = .lightGray
    return label
  }()
  
  private lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.isUserInteractionEnabled = true
    iv.clipsToBounds = true
    return iv
  }()
    
  private lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "NotoSansKR-Regular", size: 15)
    return label
  }()
  
  
  // MARK: - Lifecycle
  
  init(post: Post) {
    self.post = post
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.isToolbarHidden = false
    configureScrollView()
    configureViews()
    configureToolBar()
  }
  
  // MARK: - Action
  
  @objc func didTapCommentBtn() {
    print("DEBUG: didTapCommentBtn")
  }
  
  @objc func didTapEllipsisBtn() {
    print("DEBUG: didTapEllipsisBtn")
  }
  
  
  // MARK: - Helpers
  
  fileprivate func configureScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
  }
  
  fileprivate func configureViews() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)
    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10).isActive = true
    titleLabel.text = post.title
    
    let divider = UIView()
    contentView.addSubview(divider)
    divider.anchor(top: titleLabel.bottomAnchor, paddingTop: 8, width: view.frame.width, height: 1)
    divider.backgroundColor = .secondarySystemBackground
    
    contentView.addSubview(postTimeLabel)
    postTimeLabel.anchor(top: divider.bottomAnchor, right: titleLabel.rightAnchor,
                         paddingTop: 5, paddingRight: 8)
    postTimeLabel.text = "\(TimestampString.dateString(post.timestamp)) 전"

    if post.imageURL != "" {
      contentView.addSubview(imageView)
      imageView.anchor(top: postTimeLabel.bottomAnchor, paddingTop: 20)
      let width = view.frame.width - 60
      imageView.setDimensions(height: width, width: width)
      imageView.centerX(inView: contentView)
      imageView.kf.setImage(with: URL(string: post.imageURL))
      
      contentView.addSubview(contentLabel)
      contentLabel.anchor(top: imageView.bottomAnchor, left: titleLabel.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: titleLabel.rightAnchor, paddingTop: 15)
    } else {
      contentView.addSubview(contentLabel)
      contentLabel.anchor(top: postTimeLabel.bottomAnchor, left: titleLabel.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: titleLabel.rightAnchor, paddingTop: 20)
    }

    contentLabel.text = post.content
  }
  
  fileprivate func configureToolBar() {
    let commentBtn = UIBarButtonItem(
      image: UIImage(systemName: "bubble.left.and.bubble.right"),
      style: .plain,
      target: self,
      action: #selector(didTapCommentBtn)
    )
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    let ellipsisBtn = UIBarButtonItem(
      image: UIImage(systemName: "ellipsis"),
      style: .plain,
      target: self,
      action: #selector(didTapEllipsisBtn)
    )
    
    navigationController?.toolbar.tintColor = .black
    self.setToolbarItems([flexSpace, commentBtn, flexSpace, flexSpace, flexSpace, flexSpace, flexSpace, ellipsisBtn, flexSpace], animated: true)
  }
  
}
