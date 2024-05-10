//
//  LoginView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    let didCompleteLoginProcess: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {

                InputView(text: $viewModel.email, title: "Email", placeholder: "Test@hotmail.com")

                InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
            }

            Button {
                self.didCompleteLoginProcess()
                if formIsValid {
                    withAnimation(.easeOut(duration: 1.0)) {
                        viewModel.email = ""
                        viewModel.password = ""
                    }
                }

            } label: {
                Text("Sign In")
            }
            .font(.headline)
            .foregroundStyle(formIsValid ? .white : .black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(formIsValid ? .black : .gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .disabled(!formIsValid)

            Text(viewModel.loginStatusMessage)
                .font(.callout)
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
extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 4
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: { })
            .environmentObject(LoginViewModel())
    }
}

