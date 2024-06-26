//
//  AppError.swift
//  Peppy
//
//  Created by Shaquille McGregor on 05/05/2024.
//

import Foundation

enum AppAlert: Error, LocalizedError {
    case invalidLogin
    case invalidImage
    case createUser
    case recentMessage
    case fetchUser
    
    var title: String {
        switch self {
        case .invalidLogin: return "Login data not found"
        case .createUser: return "Failed to create user"
        case .recentMessage: return "Message failed"
        case .invalidImage: return "Image data invalid"
        case .fetchUser: return "Failed to fetch users"
        }
    }
    
    var message: String? {
        switch self {
        case .invalidLogin: return "Unable to login user, please try again"
        case .createUser: return "Unable to create account, please try again"
        case .recentMessage: return "Unable to send message, please try again"
        case .invalidImage: return "Unable to find Profile image Url, please try again"
        case .fetchUser: return "Problem fetching users from database"
        }
    }

}

enum NetworkingError: Error {
    case noInternet
    case invalidUrl
    case invalidData
    case invalidStatusCode(statusCode: Int)
    case serverError
    case fetchUser
    
    var title: String {
        switch self {
        case .noInternet: return "Bad Internet Connection"
        case .invalidUrl: return "Invalid Url"
        case .invalidData: return "Invalid Data"
        case .invalidStatusCode(statusCode: _): return "Status Code"
        case .serverError: return "Server Error"
        case .fetchUser: return "User not found"
        }
    }
    
    var message: String {
        switch self {
        case .noInternet: return "Error: No internet connection"
        case .invalidUrl: return "Error: Problem fetching Url, please try again"
        case .invalidData: return "Error: Not able to fetch data, please try again"
        case .invalidStatusCode(statusCode: _): return "Status Code response error"
        case .serverError: return "There seems to be a problem with server, please try again"
        case .fetchUser: return "Error fetching current user"
        }
    }
    
//    func handleError(error: Error, statusCode: Int) -> String {
//        switch error {
//        case NetworkingError.noInternet:
//            return "Error: No internet connection"
//        case NetworkingError.invalidUrl:
//            return "Error: Problem fetching Url, please try again"
//        case NetworkingError.invalidData:
//            return "Error: Not able to fetch data, please try again"
//        case NetworkingError.invalidStatusCode(statusCode: statusCode):
//            return "Error: Status Code response error"
//        case NetworkingError.serverError:
//            return "Error: There seems to be a problem with server, please try again"
//        default:
//            return "Error: Error is unknown"
//        }
//    }
}
