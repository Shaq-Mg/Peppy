//
//  RootView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
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
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(LoginViewModel())
    }
}
