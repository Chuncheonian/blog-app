//
//  FeedController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

private let reuseIdentifier = "PostCell"

class FeedController: UIViewController {
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(PostCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 200
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
//    tableView.fillSuperview()
//    view.backgroundColor = .blue
    tableView.dataSource = self
    
  }
}

// MARK: - UITableViewDataSource

extension FeedController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PostCell
    return cell
  }



//
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 1
//  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PostCell
//    return cell
//  }
}
