//
//  FeedController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/31.
//

import UIKit

private let reuseIdentifier = "PostCell"

class FeedController: UITableViewController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(PostCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 200
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
