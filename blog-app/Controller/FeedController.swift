//
//  FeedController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

private let reuseIdentifier = "PostCell"

class FeedController: UITableViewController {
  
  // MARK: - Properties
  
  private var user: User
  
  
  private let floatingBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.setDimensions(height: 60, width: 60)
    btn.backgroundColor = .systemCyan
    btn.tintColor = .white
    btn.layer.masksToBounds = true
    btn.layer.cornerRadius = 60 / 2
    let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .medium, scale: .default)
    let image = UIImage(systemName: "plus", withConfiguration: config)
    btn.setImage(image, for: .normal)
    return btn
  }()

  
  // MARK: - Lifecycle
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(PostCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 200
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let view = UIApplication.shared.windows.first(where: \.isKeyWindow) {
      view.addSubview(floatingBtn)
      floatingBtn.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 60, paddingRight: 20)
      floatingBtn.addTarget(self, action: #selector(didTapFloatingBtn), for: .touchUpInside)
    }
  }
    
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let view = UIApplication.shared.windows.first(where: \.isKeyWindow), floatingBtn.isDescendant(of: view) {
      floatingBtn.removeFromSuperview()
    }
  }
  
  // MARK: - Action
  
  @objc func didTapFloatingBtn() {
    let controller = UploadPostController(user: user)
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    self.present(nav, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension FeedController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PostCell
    return cell
  }
}
