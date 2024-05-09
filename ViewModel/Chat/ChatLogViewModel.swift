//
//  ChatLogViewModel.swift
//  Peppy
//
//  Created by Shaquille McGregor on 30/04/2024.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    @Published var messageCount = 0
    @Published var chatText = ""
    @Published var alertMessage = ""
    @Published var chatMessages: [ChatMessage] = []
    
    let emptyScrollToId = "Empty"
    let chatUser: User?
    
    init(chatUser: User?) {
        self.chatUser = chatUser
    }
    
    private func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.alertMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                
                DispatchQueue.main.async {
                    self.messageCount += 1
                }
            }
    }
    
    func handleSend() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore.collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: self.chatText, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.alertMessage = "Failed to save message into Firestore \(error)"
                return
            }
            print("Successfully saved current user sending message")
            self.persistRecentMessage()
            
            self.chatText = ""
            self.messageCount += 1
        }
        let recieverMessageDocument = FirebaseManager.shared.firestore.collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recieverMessageDocument.setData(messageData) { error in
            if let error = error {
                self.alertMessage = "Failed to save message into Firestore \(error)"
                return
            }
            print("Successfully saved current user sending message")
        }
    }
    
    private func persistRecentMessage() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = self.chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection("recent_message")
            .document(uid)
            .collection("messages")
            .document(toId)
        
        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.phone: chatUser?.email ?? "username"
        ] as [String : Any]
        
        // I need to save another similiar dictionary for the recipient of this message...how?
        document.setData(data) { error in
            if let error = error {
                self.alertMessage = "Failed to save recent message: \(error)"
                return
            }
        }
    }
}

