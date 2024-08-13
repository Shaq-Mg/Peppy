//
//  LoginView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com", action: { viewModel.email = "" })
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", action: { viewModel.password = "" }, isSecureField: true)
                    }
                    RegistrationButton(title: "Sign In") {
                        Task {
                            do {
                                if formIsValid {
                                    try await viewModel.signIn(withEmail: viewModel.email, password: viewModel.password)
                                    viewModel.loginStatusMessage = "Successfully logged in user: \(viewModel.userSession?.uid)"
                                }
                            } catch {
                                print("Failed to login user \(error)")
                                viewModel.loginStatusMessage = "Failed to login user: \(error)"
                            }
                        }
                    }
                    .disabled(!formIsValid)
                    
                    NavigationLink("Dont have a account? Sign up") {
                        RegistrationView()
                            .environmentObject(viewModel)
                    }
                    .font(.callout)
                    .foregroundStyle(.black)
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.white)
                        .padding(!viewModel.loginStatusMessage.isEmpty ? 8 : 0)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.red))
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
                .onAppear { viewModel.clearLoginInformation() }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
