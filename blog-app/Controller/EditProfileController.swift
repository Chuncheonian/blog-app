//
//  EditProfileController.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import UIKit

import Firebase
import Kingfisher

protocol EditProfileControllerDelegte: AnyObject {
    func didChangeUser(_ controller: EditProfileController)
}

class EditProfileController: UIViewController {

  // MARK: - Properties
  
  var viewModel: EditProfileViewModel? {
    didSet { updateUI() }
  }
  
  weak var delegate: EditProfileControllerDelegte?
  private var selectedProfileImage: UIImage?
  
  private lazy var profileImageButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .lightGray
    button.setDimensions(height: 80, width: 80)
    button.clipsToBounds = true
    button.layer.cornerRadius = 80 / 2
    button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
    return button
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "이름"
    label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
    return label
  }()
  
  private lazy var nameTextField: UITextField = {
    let tv = UITextField()
    tv.setDimensions(height: 40, width: 300)
    tv.placeholder = "이름을 입력해주세요."
    tv.font = UIFont(name: "Cera Pro Bold", size: 15)
    return tv
  }()
  
  private let bioLabel: UILabel = {
    let label = UILabel()
    label.text = "소개"
    label.font = UIFont(name: "NotoSansKR-Medium", size: 12)
    return label
  }()
  
  private lazy var bioTextView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont(name: "Cera Pro Bold", size: 15)
    tv.delegate = self
    return tv
  }()
  
  private lazy var strCountLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont(name: "NotoSansKR-Light", size: 12)
    return label
  }()
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  // MARK: - Action
  
  @objc func didTapCancel() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func didTapDone() {
    guard let viewModel = viewModel else { return }
    guard let name = nameTextField.text else { return }
    guard let biography = bioTextView.text else { return }
    
    // 사진 미 변경
    if selectedProfileImage == nil {
      let data: [String: Any] = [
        "email": viewModel.user.email,
        "name": name,
        "biography": biography,
        "profileImageURL": viewModel.user.profileImageURL,
        "uid": viewModel.user.uid
      ]
      Firestore.firestore().collection("users").document(viewModel.user.uid).setData(data, completion: nil)
    } else {  // 사진 변경
      guard let selectedProfileImage = selectedProfileImage else { return }
      ImageUploader.uploadImage(image: selectedProfileImage, uid: viewModel.user.uid) { imageURL in
        let data: [String: Any] = [
          "email": viewModel.user.email,
          "name": name,
          "biography": biography,
          "profileImageURL": imageURL,
          "uid": viewModel.user.uid
        ]
        Firestore.firestore().collection("users").document(viewModel.user.uid).setData(data, completion: nil)
      }
    }
    self.delegate?.didChangeUser(self)
  }
  
  @objc func handleProfilePhotoSelect() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    present(picker, animated: true, completion: nil)
  }
  
  // MARK: - Helper
    
  fileprivate func configure() {
    navigationItem.title = "프로필 편집"
    view.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .black
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "취소",
      style: .plain,
      target: self,
      action: #selector(didTapCancel)
    )
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "완료",
      style: .plain,
      target: self,
      action: #selector(didTapDone)
    )
    
    view.addSubview(profileImageButton)
    profileImageButton.centerX(inView: view)
    profileImageButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
    let nameStack = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
    nameStack.axis = .horizontal
    nameStack.spacing = 12
    view.addSubview(nameStack)
    nameStack.anchor(top: profileImageButton.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 16)
    
    let topDivider = UIView()
    view.addSubview(topDivider)
    topDivider.anchor(top: nameStack.bottomAnchor, paddingTop: 10)
    topDivider.backgroundColor = .systemGray5
    topDivider.setDimensions(height: 0.5, width: view.frame.width)
    
    view.addSubview(bioLabel)
    bioLabel.anchor(top: topDivider.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 16)
    
    view.addSubview(strCountLabel)
    strCountLabel.anchor(top: topDivider.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 16)
    
    view.addSubview(bioTextView)
    bioTextView.anchor(top: bioLabel.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 12,
                         paddingLeft: 12, paddingRight: 12, height: 200)
    
    let bottomDivider = UIView()
    view.addSubview(bottomDivider)
    bottomDivider.anchor(top: bioTextView.bottomAnchor, paddingTop: 10)
    bottomDivider.backgroundColor = .systemGray5
    bottomDivider.setDimensions(height: 0.5, width: view.frame.width)
  }
  
  fileprivate func updateUI() {
    guard let viewModel = viewModel else { return }
    profileImageButton.kf.setImage(with: viewModel.profileImageURL, for: .selected)
    profileImageButton.kf.setBackgroundImage(with: viewModel.profileImageURL, for: .normal)
    nameTextField.text = viewModel.name
    bioTextView.text = viewModel.biography
    strCountLabel.text = viewModel.biographyCount
  }
  
  func checkMaxLength(_ textView: UITextView) {
    if (textView.text.count) > 1000 {
      textView.deleteBackward()
    }
  }
}

// MARK: - UIImagePickerControllerDelegate

// UIImagePickerControllerDelegate을 채택할떄는 UINavigationControllerDelegate도 같이 채택해야 한다.
extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    selectedProfileImage = selectedImage
        
    profileImageButton.layer.cornerRadius = profileImageButton.frame.width / 2
    profileImageButton.layer.masksToBounds = true
    profileImageButton.layer.borderColor = UIColor.white.cgColor
    profileImageButton.layer.borderWidth = 2
    profileImageButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITextFieldDelegate

extension EditProfileController: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    checkMaxLength(textView)
    let count = textView.text.count
    strCountLabel.text = "\(count)/1000"
  }
}
