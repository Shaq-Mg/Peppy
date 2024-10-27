//
//  AuthenticationViewModel.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
}
