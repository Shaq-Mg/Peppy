//
//  CreateAccountView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                InputView(text: $authVM.name, title: "Name", placeholder: "Enter name")
                    .textInputAutocapitalization(.none)
                InputView(text: $authVM.email, title: "Email Address", placeholder: "Enter email")
                    .textInputAutocapitalization(.none)
                InputView(text: $authVM.password, title: "Password", placeholder: "Enter password", isSecureField: true)
                    .keyboardType(.numberPad)
                
                InputView(text: $authVM.confirmPassword, title: "Confirm Password", placeholder: "Confirm password", isSecureField: true)
                    .keyboardType(.numberPad)
                
                Text(authVM.errorMessage)
                    .font(.callout)
                
                RegistrationButtonView(title: "Create Account") {
                    Task {
                        try await authVM.createUser(withEmail: authVM.email, name: authVM.name, password: authVM.password)
                    }
                }
                .padding(.top, 44)
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Already have a existing account?")
                    Text("Sign In")
                        .bold()
                })
                .foregroundStyle(.black)
            }
            .padding(.horizontal)
            .navigationTitle("Create account")
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
            .environmentObject(AuthenticationViewModel())
    }
}
