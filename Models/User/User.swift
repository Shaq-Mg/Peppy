//
//  User.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import Foundation
import Firebase

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
    }
    
    var firstLetter: String {
        return String(name.prefix(1))
    }
}

extension User {
    static var mock_user = User(id: NSUUID().uuidString, name: "Kobe Bryant", email: "kobe@gmail.com")
}
