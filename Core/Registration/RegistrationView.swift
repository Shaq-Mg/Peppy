//
//  RegistrationView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        InputView(text: $viewModel.name, title: "Name", placeholder: "Name", action: { viewModel.name = "" })
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com", action: { viewModel.email = "" })
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", action: { viewModel.password = "" }, isSecureField: true)
                        
                        InputView(text: $viewModel.confirmPassword, title: "Confirm Password", placeholder: "Confirm password", action: { viewModel.confirmPassword = "" }, isSecureField: true)
                        
                        buttonSection
                            .padding(.top)
                    }
                }
                .padding(.horizontal)
                .onAppear { viewModel.clearLoginInformation() }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}

extension RegistrationView {
    private var buttonSection: some View {
        VStack(spacing: 16) {
            RegistrationButton(title: "Create account") {
                Task {
                    do {
                        if formIsValid {
                            try await viewModel.signUp(withEmail: viewModel.email, name: viewModel.name, password: viewModel.password, confirmPassword: viewModel.confirmPassword)
                            
                            viewModel.loginStatusMessage = "Successfully created user: \(viewModel.userSession?.uid)"
                        }
                    } catch {
                        print("Failed to login user \(error)")
                        viewModel.loginStatusMessage = "Failed to login user: \(error)"
                    }
                }
            }
            .disabled(!formIsValid)
            
            Button("Already have a account? Login") {
                dismiss()
            }
            .font(.callout)
            .foregroundStyle(.black)
            
            Text(viewModel.loginStatusMessage)
                .padding(!viewModel.loginStatusMessage.isEmpty ? 8 : 0)
                .background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.red))
                .shadow(radius: 2)
        }
    }
}
