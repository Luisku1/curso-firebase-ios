//
//  UserService.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import Foundation
import FirebaseAuth

struct UserService
{
    static func saveUser(uid : String, credential : AuthCredential, imageUrl : String)
    {
        USERS_COLLECTION.document(uid).setData([
        
            "name" : credential.name,
            "email" : credential.email,
            "image" : imageUrl
        ])
    }
    
    static func getUser(completion : @escaping(User) -> Void)
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        USERS_COLLECTION.document(uid).getDocument { userDocument, error in
            
            guard let documentData = userDocument?.data() else { return }
            
            let user = User(withDictionary: documentData)
            completion(user)
        }
    }
    
    static func getUsers(completion : @escaping([User]) -> Void)
    {
        USERS_COLLECTION.getDocuments { snapshot, error in
            
            guard let documents = snapshot?.documents else { return }
            
            let users = documents.map({User(withDictionary: $0.data())})
            completion(users)
        }
    }
}
