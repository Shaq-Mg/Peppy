//
//  FirebaseManager.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager: NSObject {
     let auth: Auth
     let storage: Storage
     let firestore: Firestore
     
     static let shared = FirebaseManager()
     
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super .init()
    }
}
