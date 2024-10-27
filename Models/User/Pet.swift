//
//  Pet.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import Foundation

struct Pet: Identifiable, Codable {
    let id: String
    let name: String
    let animal: Animal
    let age: Int
}

enum Animal: String, CaseIterable, Codable {
    case dog = "Dog"
    case cat = "Cat"
}

extension Pet {
    static var mock_data = Pet(id: NSUUID().uuidString, name: "Tokyo", animal: .dog, age: 6)
}
