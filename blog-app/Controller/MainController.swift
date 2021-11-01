//
//  MainController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit

import Firebase
import Parchment

class MainController: UIViewController {
  
  // MARK: - Properties
  
  let menuArr = ["글", "소개"]
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavi()
    configureUI()
    checkIfUserIsLoggedIn()
  }
  
  // MARK: - API
  
  func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser == nil {
      // Auth.auth()가 global Queue로 돌기 때문에 mainQueue로 빼줌
      print(1123)
//      DispatchQueue.main.async {
//        let controller = LoginController()
//        controller.delegate = self
//        let nav = UINavigationController(rootViewController: controller)
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
//      }
    }
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

    // PagingViewController
    let viewControllers = [FeedController(), IntroController()]
    let pagingVC = PagingViewController(viewControllers: viewControllers)
    addChild(pagingVC)
    view.addSubview(pagingVC.view)
    pagingVC.didMove(toParent: self)
    pagingVC.view.anchor(top: profile.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    pagingVC.dataSource = self
    
    pagingVC.menuItemSize = .fixed(width: 45, height: 35)
    pagingVC.menuInsets = UIEdgeInsets(top: 0, left: 33, bottom: 0, right: 0)
    pagingVC.menuItemSpacing = 18
    pagingVC.menuItemLabelSpacing = 0
    
    pagingVC.indicatorOptions = .visible(height: 2, zIndex: Int.max, spacing: UIEdgeInsets.zero, insets: UIEdgeInsets.zero)  // 하단 Bar
    pagingVC.indicatorColor = .black
    
    pagingVC.font = UIFont(name: "NotoSansKR-Regular", size: 13)!
    pagingVC.selectedFont = UIFont(name: "NotoSansKR-Regular", size: 13)!
    pagingVC.textColor = .systemGray
    pagingVC.selectedTextColor = .black
  }
}

// MARK: - PagingViewControllerDataSource

extension MainController: PagingViewControllerDataSource {
  func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
    return menuArr.count
  }
  
  func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
    if index == 0 {
      return FeedController()
    } else {
      return IntroController()
    }
  }
  
  func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
    return PagingIndexItem(index: index, title: menuArr[index])
  }
}
