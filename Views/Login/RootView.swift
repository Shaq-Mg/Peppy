//
//  RootView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    let didCompleteLoginProcess: () -> ()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("Login Status", selection: $viewModel.isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(.segmented).padding(.bottom)
                    if viewModel.isLoginMode {
                        LoginView(didCompleteLoginProcess: {
                            self.signIn()
                        })
                    } else {
                        RegistrationView()
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(viewModel.isLoginMode ? "Sign In" : "Create Account")
            .background(.mint.opacity(0.4))
        }
    }
    private func signIn() {
        FirebaseManager.shared.auth.signIn(withEmail: viewModel.email, password: viewModel.password) {
            result, error in
            if let error = error {
                print("Failed to login user:", error)
                viewModel.showAlert = AppAlert.invalidLogin
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            viewModel.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            //dismiss RootView once signed in succcessfully
            self.didCompleteLoginProcess()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(didCompleteLoginProcess: { })
            .environmentObject(LoginViewModel())
    }
}
