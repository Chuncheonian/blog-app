//
//  MainController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit
import PagingKit

class MainController: UIViewController {
  
  // MARK: - Properties
  
  let pagingMenuVC = PagingMenuViewController()
  let pagingContentVC = PagingContentViewController()
    
  var dataSource = [(menu: String, content: UIViewController)]() {
    didSet {
      pagingMenuVC.reloadData()
      pagingContentVC.reloadData()
    }
  }
  
  lazy var firstLoad: (() -> Void)? = { [weak self, pagingMenuVC, pagingContentVC] in
    pagingMenuVC.reloadData()
    pagingContentVC.reloadData()
    self?.firstLoad = nil
  }
  
  // MARK: - Lifecycle

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    firstLoad?()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
  }
  
  // MARK: - Actions

  @objc func handleSearch() {
    print("DEBUG: Clicked Search Icon")
  }
  
  @objc func handleNoti() {
    print("DEBUG: Clicked Noti Icon")
  }
  
  @objc func handleSeting() {
    print("DEBUG: Clicked Setting Icon")
  }
  
  // MARK: - Helpers
  
  fileprivate func configureNavi() {
    view.backgroundColor = .white
    self.navigationController?.navigationBar.tintColor = .black
    
    let searchIcon = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(handleSearch))
    let notiIcon = UIBarButtonItem(image: UIImage(systemName: "flame"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(handleNoti))
    let settingIcon = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(handleSeting))
    
    navigationItem.leftBarButtonItem = searchIcon
    navigationItem.rightBarButtonItems = [settingIcon, notiIcon]
  }
  
  fileprivate func configureUI() {
    
    // Profile
    let profile = Profile()
    view.addSubview(profile)
    profile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
    profile.setHeight(100)

    // PagingMenu
    addChild(pagingMenuVC)
    view.addSubview(pagingMenuVC.view)
    pagingMenuVC.didMove(toParent: self)
    pagingMenuVC.view.anchor(top: profile.bottomAnchor, left: view.leftAnchor, paddingLeft: 33)
    pagingMenuVC.view.setDimensions(height: 35, width: 100)
    pagingMenuVC.register(type: PagingMenuCell.self, forCellWithReuseIdentifier: "PagingMenuCell")
    
    // PagingMenuFocusView in PagingMenu
    let pagingMenuFocusView = UnderlineFocusView()
    pagingMenuFocusView.underlineColor = .black
    pagingMenuFocusView.underlineHeight = 2
    pagingMenuVC.registerFocusView(view: pagingMenuFocusView)
    pagingMenuVC.dataSource = self
    pagingMenuVC.delegate = self
    
    // Divider
    let divider = UIView()
    divider.backgroundColor = .systemGray5
    view.addSubview(divider)
    divider.anchor(top: pagingMenuVC.view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 1)
    
    // PagingContent
    addChild(pagingContentVC)
    view.addSubview(pagingContentVC.view)
    pagingContentVC.didMove(toParent: self)
    pagingContentVC.view.anchor(top: divider.bottomAnchor, left: view.leftAnchor,
                                    bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    pagingContentVC.dataSource = self
    pagingContentVC.delegate = self
    
    dataSource = makeDataSource()
  }
  
  fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
    let menuArr = ["글", "소개"]

    return menuArr.map {
      let title = $0

      switch title {
      case "글":
        let vc = FeedController()
        return (menu: title, content: vc)
      case "소개":
        let vc = IntroController()
        return (menu: title, content: vc)
      default:
        let vc = FeedController()
        return (menu: title, content: vc)
      }
    }
  }
}


// MARK: - PagingMenuViewControllerDelegate

extension MainController: PagingMenuViewControllerDelegate {
  func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
    pagingContentVC.scroll(to: page, animated: true)
  }
}

// MARK: - PagingMenuViewControllerDataSource

extension MainController: PagingMenuViewControllerDataSource {
  func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
    return dataSource.count
  }
  
  func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
    return 100 / 2
  }
  
  func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
    let cell = viewController.dequeueReusableCell(withReuseIdentifier: "PagingMenuCell", for: index) as! PagingMenuCell
    cell.titleLabel.text = dataSource[index].menu
    return cell
  }
}

// MARK: - PagingContentViewControllerDelegate

extension MainController: PagingContentViewControllerDelegate {
  func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
    pagingMenuVC.scroll(index: index, percent: percent, animated: false)
  }
}

// MARK: - PagingContentViewControllerDataSource

extension MainController: PagingContentViewControllerDataSource {
  func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
    return dataSource.count
  }
  
  func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
    return dataSource[index].content
  }
}
