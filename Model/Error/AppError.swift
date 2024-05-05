//
//  AppError.swift
//  Peppy
//
//  Created by Shaquille McGregor on 05/05/2024.
//

import Foundation

enum AppError: Error {
    case login
    case createUser
    case database
    case recentMessage
    case uploadPhotoUrl
    
    var title: String {
        switch self {
        case .login:
            return "Error: unable to login user"
        case .createUser:
            return "Error: unable to create user"
        case .database:
            return "Error: unable to fetch user"
        case .recentMessage:
            return "Error: unable to send recent message"
        case .uploadPhotoUrl:
            return "Error: unable to upload photo Url"
        }
    }
}

enum NetworkError: Error {
    case noInternet
    case serverError
    case unknown
}
