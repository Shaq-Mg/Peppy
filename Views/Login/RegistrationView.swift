//
//  RegistrationView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(spacing: 8) {
                InputView(text: $viewModel.username, title: "Username", placeholder: "Username")
                
                InputView(text: $viewModel.email, title: "Email", placeholder: "Test@hotmail.com")
//                    .keyboardType(.decimalPad)
                
                InputView(text: $viewModel.password, title: "Password", placeholder: "Password", isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $viewModel.confirmPassword, title: "Confirm Password", placeholder: "Confirm Password", isSecureField: true)
                    
                    if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                        if viewModel.password == viewModel.confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
            }
            
            Button {
                viewModel.createAccount()
                if formIsValid {
                    withAnimation(.easeOut(duration: 1.0)) {
                        viewModel.username = ""
                        viewModel.email = ""
                        viewModel.password = ""
                        viewModel.confirmPassword = ""
                    }
                }
                
            } label: {
                Text("Create Account")
                    .font(.headline)
                    .foregroundStyle(formIsValid ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(formIsValid ? .black : .gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert(viewModel.showAlert?.title ?? "Error", isPresented: Binding(value: $viewModel.showAlert), actions: {
            Button("OK") {
                viewModel.showAlert = nil
            }
        }, message: {
            if let message = viewModel.showAlert?.message {
                Text(message)
            }
        })
    }
}
extension RegistrationView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.username.isEmpty
        && viewModel.username.count > 3
        && !viewModel.password.isEmpty
        && viewModel.password.count > 4
        && viewModel.confirmPassword == viewModel.password
    }
}
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(LoginViewModel())
    }
}
