//
//  AppError.swift
//  Peppy
//
//  Created by Shaquille McGregor on 05/05/2024.
//

import Foundation

enum AppAlert: Error, LocalizedError {
    case login
    case createUser
    case database
    case recentMessage
    case invalidUrl
    
    var title: String {
        switch self {
        case .login:
            return "Login data not found"
        case .createUser:
            return "User not found"
        case .database:
            return "User not found"
        case .recentMessage:
            return "Message failed"
        case .invalidUrl:
            return "Url not found"
        }
    }
    
    var message: String? {
        switch self {
        case .login:
            return "Unable to login user, please try again"
        case .createUser:
            return "Unable to create user, please try again"
        case .database:
            return "Unable to fetch data, please try again"
        case .recentMessage:
            return "Unable to send message, please try again"
        case .invalidUrl:
            return nil
        }
    }

}

enum NetworkError: Error {
    case noInternet
    case serverError
    case other
    
    func handleError(error: Error) -> String {
        switch error {
        case NetworkError.noInternet:
            return "Error: No internet connection"
        case NetworkError.serverError:
            return "Error: No Server error"
        case NetworkError.other:
            return "Error: Error is unknown"
        default:
            return "Error: Error is unknown"
        }
    }
}
