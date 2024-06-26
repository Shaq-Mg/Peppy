//
//  MessagesViewModel.swift
//  Peppy
//
//  Created by Shaquille McGregor on 30/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class MessagesViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var showAlert: AppAlert? = nil
    @Published var chatUser: User?
    @Published var recentMessages: [RecentMessage] = []
    
    @Published var showNewMessageScreen = false
    @Published var shouldNavigateToChatView = false
    
    init() {
        fetchRecentMessages()
        fetchCurrentUser()
    }
    
    private func fetchRecentMessages() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("recent_messages").document(uid).collection("messages")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages: \(error)"
                    return
                }
                querySnapshot?.documentChanges.forEach( { change in
                    let docId = change.document.documentID
                    
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.id == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    do {
                        if let rm = try? change.document.data(as: RecentMessage.self) {
                            self.recentMessages.insert(rm, at: 0)
                        }
                    } catch {
                        self.showAlert = AppAlert.recentMessage
                    }
                })
            }
    }
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            guard let data = snapshot?.data() else {
                self.showAlert = AppAlert.fetchUser
                self.errorMessage = "No data found"
                return
            }
            self.chatUser = .init(data: data)
        }
    }
}
