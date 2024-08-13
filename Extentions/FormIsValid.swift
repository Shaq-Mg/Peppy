//
//  FormIsValid.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import Foundation

extension LoginView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count >= 5
    }
}

extension RegistrationView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.name.isEmpty
        && viewModel.name.count >= 3
        && !viewModel.password.isEmpty
        && viewModel.password.count >= 5
        && viewModel.confirmPassword == viewModel.password
    }
}
