//
//  ImageUploaderService.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage

struct ImageUploaderService
{
    static func uploadUserImage(image : UIImage, completion : @escaping(String) -> Void)
    {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        storageRef.putData(imageData) { metadata, error in
            
            if let error = error
            {
                print("DEBUG: - Image Uploader \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { imageUrl, error in
                
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
