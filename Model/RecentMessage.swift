//
//  RecentMessage.swift
//  Peppy
//
//  Created by Shaquille McGregor on 29/04/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    let fromId, toId: String
    let username, email, text: String
    let timestamp: Date
}
