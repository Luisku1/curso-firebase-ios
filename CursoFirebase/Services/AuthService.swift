//
//  AuthService.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

struct AuthCredential
{
    var name : String
    var email : String
    var password : String
    var image : UIImage
}

struct AuthService
{
    static func registerUser(withCredentials credential : AuthCredential, completion : @escaping(Error?) -> Void) -> Void
    {
        ImageUploaderService.uploadUserImage(image: credential.image) { imageUrl in
            
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                
                if let result = result, error == nil
                {
                    let uid = result.user.uid
                    
                    UserService.saveUser(uid : uid, credential: credential, imageUrl: imageUrl)
                
                } else {
                    
                    print("DEBUG: - Authenticating user \(error!.localizedDescription)")
                    return
                }
            }
        }
    }
}
