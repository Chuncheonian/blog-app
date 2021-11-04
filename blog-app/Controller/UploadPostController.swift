//
//  UploadPostController.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import UIKit
import IQKeyboardManagerSwift

protocol UploadPostControllerDelegte: AnyObject {
    func didUploadPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
  
  // MARK: - Properties
  
  private var user: User
  weak var delegate: UploadPostControllerDelegte?
  private var selectedImage: UIImage?
  
  private lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.isUserInteractionEnabled = true
    iv.clipsToBounds = true
    return iv
  }()
  
  private let titleField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "제목을 입력해주세요."
    tf.font = UIFont(name: "Cera Pro Bold", size: 18)
    tf.autocapitalizationType = .words
    tf.autocorrectionType = .yes
    tf.layer.masksToBounds = true
    return tf
  }()
  
  private let contentView: InputTextView = {
    let tv = InputTextView()
    tv.placeholderText = "내용을 입력해주세요."
    tv.textContainerInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
    tv.isEditable = true
    tv.font = UIFont(name: "NotoSansKR-Regular", size: 16)
    return tv
  }()
  
  private let toolBarKeyboard: UIToolbar = {
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let doneToolBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapDoneToolBtn))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let photoBtn = UIBarButtonItem(
      image: UIImage(systemName: "photo.on.rectangle.angled"),
      style: .plain,
      target: self,
      action: #selector(didTapPhotoToolBtn)
    )
    toolBar.items = [photoBtn, flexSpace, doneToolBtn]
    toolBar.tintColor = .black
    return toolBar
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
    configure()
  }
  
  
  // MARK: - Action
  
  @objc func didTapCancel() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func didTapDone() {
    guard let title = titleField.text else { return }
    guard let content = contentView.text else { return }
    
    PostService.uploadPost(title: title, content: content, image: selectedImage, user: user) { error in
      if let error = error {
        print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
        return
      }
      self.dismiss(animated: true, completion: nil)
    }
//      self.delegate?.didUploadPost(self)
  }
  
  @objc func didTapDoneToolBtn() {
    self.view.endEditing(true)
  }
  
  @objc func didTapPhotoToolBtn() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    present(picker, animated: true, completion: nil)
  }
    
  
  // MARK: - Helpers
  
  fileprivate func configure() {
    IQKeyboardManagerSwift.IQKeyboardManager.shared.enableAutoToolbar = false
    navigationItem.title = "글 작성"
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
    
    view.addSubview(imageView)
    imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10, width: 80, height: 80)
    imageView.centerX(inView: view)
    
    view.addSubview(titleField)
    titleField.anchor(top: imageView.bottomAnchor, left: view.leftAnchor,
                        right: view.rightAnchor, paddingTop: 20,
                        paddingLeft: 16, paddingRight: 16,
                        height: 30)
    titleField.becomeFirstResponder()
    
    let divider = UIView()
    view.addSubview(divider)
    divider.anchor(top: titleField.bottomAnchor, paddingTop: 1, width: view.frame.width, height: 0.5)
    divider.backgroundColor = .secondarySystemBackground
    
    
    view.addSubview(contentView)
    contentView.anchor(top: divider.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         paddingTop: 15, width: view.frame.width)
    titleField.inputAccessoryView = toolBarKeyboard
    contentView.inputAccessoryView = toolBarKeyboard
    
  }
}


// MARK: - UIImagePickerControllerDelegate

// UIImagePickerControllerDelegate을 채택할떄는 UINavigationControllerDelegate도 같이 채택해야 한다.
extension UploadPostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
    guard let image = info[.editedImage] as? UIImage else { return }
    selectedImage = image
    imageView.image = image
        
    self.dismiss(animated: true, completion: nil)
  }
}
