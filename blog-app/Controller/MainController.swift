//
//  MainController.swift
//  blog-app
//
//  Created by dykoon on 2021/10/30.
//

import UIKit

class MainController: UIViewController {
  
  
  // MARK: - Lifecycle
  
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
  
  func configureNavi() {
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
  
  func configureUI() {
    
    let profile = Profile()
    
    view.addSubview(profile)
    profile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
    profile.setHeight(100)
    
  }

  
  
  
}
