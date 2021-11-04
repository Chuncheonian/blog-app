//
//  EditPostController.swift
//  blog-app
//
//  Created by dykoon on 2021/11/05.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher

protocol EditPostControllerDelegte: AnyObject {
  func didFinishEditingPost(_ controller: EditPostController)
}

class EditPostController: UIViewController {
  
  // MARK: - Properties
  
  var viewModel: EditPostViewModel? {
    didSet { updateUI() }
  }
  weak var delegate: EditPostControllerDelegte?
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
  
  private let contentView: UITextView = {
    let tv = UITextView()
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
    guard let title = titleField.text else { return }
    guard let content = contentView.text else { return }
    
    self.showLoader(true)
    
    PostService.updatePost(title: title, content: content, image: selectedImage, user: viewModel.user, post: viewModel.post) { error in
      self.showLoader(false)
      if let error = error {
        print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
        return
      }
      self.delegate?.didFinishEditingPost(self)
    }
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
    navigationItem.title = "글 편집"
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
  
  fileprivate func updateUI() {
    guard let viewModel = viewModel else { return }
    imageView.kf.setImage(with: viewModel.imageURL)
    titleField.text = viewModel.title
    contentView.text = viewModel.content

  }
}


// MARK: - UIImagePickerControllerDelegate

// UIImagePickerControllerDelegate을 채택할떄는 UINavigationControllerDelegate도 같이 채택해야 한다.
extension EditPostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
    guard let image = info[.editedImage] as? UIImage else { return }
    selectedImage = image
    imageView.image = image
        
    self.dismiss(animated: true, completion: nil)
  }
}
