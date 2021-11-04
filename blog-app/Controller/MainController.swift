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
  
  private var user: User {
    didSet { updateUI() }
  }
  
  private let profile = ProfileView()
  private let pagingVC = PagingViewController()
  private let menuArr = ["글", "소개"]
  private let intro = IntroController()
  private let email = "admin@gmail.com"  // 자동로그인 가정
  private let password = "123456"         // 자동로그인 가정

  
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
    configure()
    checkIfUserIsLoggedIn()
  }
  
  override func viewWillAppear(_ animated: Bool) {
     checkIfUserIsLoggedIn()
  }
  
  // MARK: - API
  
  fileprivate func checkIfUserIsLoggedIn() {
    
    if Auth.auth().currentUser == nil {
      self.configureGuestUI()
    } else {
      self.configureManagerUI()
    }
  }
  
  // MARK: - Actions

  @objc func didTapSearch() {
    print("DEBUG: Clicked Search Icon")
  }
  
  
  // MARK: - Helpers
  
  fileprivate func configure() {
    view.backgroundColor = .white
    self.navigationController?.navigationBar.tintColor = .black
    
    let searchIcon = UIBarButtonItem(
      image: UIImage(systemName: "magnifyingglass"),
      style: .plain,
      target: self,
      action: #selector(didTapSearch)
    )
    navigationItem.leftBarButtonItem = searchIcon
    
    // Profile
    profile.viewModel = ProfileViewModel(user: user)
    view.addSubview(profile)
    profile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
    profile.setHeight(100)
    
    // PagingViewController
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
  
  fileprivate func configureGuestUI() {
    let settingIcon = UIBarButtonItem(
      title: nil,
      image: UIImage(systemName: "gearshape"),
      primaryAction: nil,
      menu: createGuestMenu()
    )
    navigationItem.rightBarButtonItem = settingIcon
  }
  
  func configureManagerUI() {

    let settingIcon = UIBarButtonItem(
      title: nil,
      image: UIImage(systemName: "gearshape"),
      primaryAction: nil,
      menu: createManagerMenu()
    )
    self.navigationItem.rightBarButtonItem = settingIcon
  }
  
  fileprivate func updateUI() {
    profile.viewModel = ProfileViewModel(user: user)
    intro.viewModel = IntroViewModel(user: user)
  }
}

// MARK: - UIMenu

extension MainController {
  
  // 임시로 자동 로그인
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
    
    return UIMenu(title: "", children: [logInAction, settingAction])
  }
  
  func createManagerMenu() -> UIMenu {
    
    let profileEditAction = UIAction(
      title: "프로필 편집",
      image: UIImage(systemName: "person.text.rectangle")
    ) { _ in
      let controller = EditProfileController()
      controller.viewModel = EditProfileViewModel(user: self.user)
      controller.delegate = self
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
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
      let feed = FeedController()
      return feed
    } else {
      intro.viewModel = IntroViewModel(user: user)
      return intro
    }
  }
  
  func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
    return PagingIndexItem(index: index, title: menuArr[index])
  }
}

// MARK: - EditProfileControllerDelegte

extension MainController: EditProfileControllerDelegte {
  func didChangeUser(_ controller: EditProfileController) {
    controller.dismiss(animated: true, completion: nil)
    UserService.fetchUser { user in
      self.user = user
    }
  }
}
