//
//  User.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String { uid }
    
    var uid, username, email, photoImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.photoImageUrl = data["photoImageURL"] as? String ?? ""
    }
}
