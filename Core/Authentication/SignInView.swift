//
//  SignInView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                InputView(text: $authVM.email, title: "Email Address", placeholder: "Email")
                    .textInputAutocapitalization(.none)
                InputView(text: $authVM.password, title: "Password", placeholder: "Password", isSecureField: true)
                    .keyboardType(.numberPad)
                
                Text(authVM.errorMessage)
                    .font(.callout)
                
                RegistrationButtonView(title: "Sign In") {
                    
                }
                .padding(.top, 44)
                
                NavigationLink(destination: {
                    CreateAccountView()
                        .navigationBarBackButtonHidden(true)
                }, label: {
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .bold()
                })
                .foregroundStyle(.black)
            }
            .padding(.horizontal)
            .navigationTitle("Sign In")
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
            .environmentObject(AuthenticationViewModel())
    }
}
