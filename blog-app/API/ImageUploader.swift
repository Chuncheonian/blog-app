//
//  ImageUploader.swift
//  blog-app
//
//  Created by dykoon on 2021/11/01.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    
  static func uploadImage(image: UIImage, uid: String, completion: @escaping(String) -> Void) {
        
    // UIImage -> Data
    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
    let filename = uid
    let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        print("DEBUG: Failed to upload image \(error.localizedDescription)")
        return
      }
            
      ref.downloadURL { url, error in
        guard let imageURL = url?.absoluteString else { return }
        completion(imageURL)
      }
    }
  }
  
  static func uploadPostImage(image: UIImage, uuid: String, completion: @escaping(String) -> Void) {
        
    // UIImage -> Data
    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
    let filename = uuid
    let ref = Storage.storage().reference(withPath: "/post_images/\(filename)")
        
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        print("DEBUG: Failed to upload image \(error.localizedDescription)")
        return
      }
            
      ref.downloadURL { url, error in
        guard let imageURL = url?.absoluteString else { return }
        completion(imageURL)
      }
    }
  }
}
