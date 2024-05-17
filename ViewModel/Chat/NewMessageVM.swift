//
//  NewMessageVM.swift
//  Peppy
//
//  Created by Shaquille McGregor on 29/04/2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class NewMessageVM: ObservableObject {
    
    @Published var users: [User] = []
    @Published var chatUser: User?
    @Published var errorMesssge = ""
    @Published var showAlert: NetworkingError? = nil
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMesssge = "Failed to fetch users: \(error)"
                    self.showAlert = NetworkingError.fetchUser
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = User(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
                self.errorMesssge = "Fetched users successfully"
            }
    }
}
