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
  
  private let menuArr = ["글", "소개"]
  private var user: User?
  private let email = "admin@gmail.com"
  private let password = "123456"
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    checkIfUserIsLoggedIn()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    checkIfUserIsLoggedIn()
  }
  
  // MARK: - API
    
  fileprivate func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser == nil {
      self.configureGuestUI()
    } else {
      UserService.fetchUser { user in
        self.user = user
        self.configureManagerUI(withUser: user)
      }
    }
  }
  
  // MARK: - Actions

  @objc func handleSearch() {
    print("DEBUG: Clicked Search Icon")
  }
  
  @objc func handleNoti() {
    print("DEBUG: Clicked Noti Icon")
  }
  
  // MARK: - Helpers
  
  fileprivate func configure() {
    view.backgroundColor = .white
    self.navigationController?.navigationBar.tintColor = .black
    
    let searchIcon = UIBarButtonItem(
      image: UIImage(systemName: "magnifyingglass"),
      style: .plain,
      target: self,
      action: #selector(handleSearch)
    )
    
    navigationItem.leftBarButtonItem = searchIcon
  }
  
  fileprivate func configureGuestUI() {

    let settingIcon = UIBarButtonItem(
      title: nil,
      image: UIImage(systemName: "gearshape"),
      primaryAction: nil,
      menu: createGuestMenu()
    )
    
    navigationItem.rightBarButtonItems = [settingIcon]
  }
  
  func configureManagerUI(withUser user: User) {
    
    let notiIcon = UIBarButtonItem(
      image: UIImage(systemName: "flame"),
      style: .plain,
      target: self,
      action: #selector(self.handleNoti)
    )

    let settingIcon = UIBarButtonItem(
      title: nil,
      image: UIImage(systemName: "gearshape"),
      primaryAction: nil,
      menu: createManagerMenu(user)
    )

    self.navigationItem.rightBarButtonItems = [settingIcon, notiIcon]
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

// MARK: - UIMenu

extension MainController {
  
  func createGuestMenu() -> UIMenu {
    let logInAction = UIAction(
      title: "관리자 모드",
      image: UIImage(systemName: "person.fill.questionmark")
    ) { _ in
      AuthService.logUserIn(
        withEmail: self.email,
        password: self.password
      ) { result, error in
        if let error = error {
          print("DEBUG: Failed to log user in \(error.localizedDescription)")
          return
        }
        self.viewWillAppear(true)
      }
    }
    
    let settingAction = UIAction(
      title: "설정",
      image: UIImage(systemName: "gearshape")
    ) { _ in
      let controller = SettingController()
      self.navigationController?.pushViewController(controller, animated: true)
    }
    
    return UIMenu(
      title: "",
      children: [logInAction, settingAction]
    )
  }
  
  func createManagerMenu(_ user: User) -> UIMenu {
    
    let profileEditAction = UIAction(
      title: "프로필 편집",
      image: UIImage(systemName: "person.text.rectangle")
    ) { _ in
      let editProfileController = EditProfileController()
      self.present(editProfileController, animated: true, completion: nil)
    }
    
    let settingAction = UIAction(
      title: "설정",
      image: UIImage(systemName: "gearshape")
    ) { _ in
      let controller = SettingController()
      self.navigationController?.pushViewController(controller, animated: true)
    }
    
    let logoutAction = UIAction(
      title: "로그아웃",
      image: UIImage(systemName: "figure.wave"),
      attributes: .destructive
    ) { _ in
      do {
        try Auth.auth().signOut()
        self.user = nil
        self.viewWillAppear(true)
      } catch {
        print("DEBUG: Failed to Sign out")
      }
    }
    
    return UIMenu(
      title: "\(user.email)",
      children: [profileEditAction, settingAction, logoutAction]
    )
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
