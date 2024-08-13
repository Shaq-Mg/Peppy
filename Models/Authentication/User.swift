//
//  User.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
