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
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                
                InputView(text: $viewModel.phone, title: "Phone Number", placeholder: "+44 *********")
                
                InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
            }
            
            Button {
                viewModel.handleAction()
            } label: {
                Text("Sign In")
            }
            .font(.headline)
            .foregroundStyle(formIsValid ? .white : .black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(formIsValid ? .black : .gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .disabled(formIsValid)
            
            Text(viewModel.loginStatusMessage)
        }
    }
}
extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModel.phone.isEmpty
        && viewModel.phone.count == 11
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}

