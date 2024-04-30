//
//  UserManager.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    func createNewUser(user: User) async throws {
        let userData: [String:Any] = [
            "user_id" : user.uid,
            "username" : user.username,
            "phone" : user.phone
        ]
        try await Firestore.firestore().collection("users").document(user.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        
        return User(data: data)
        
    }
}
