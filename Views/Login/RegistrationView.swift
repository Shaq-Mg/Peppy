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
            PhotoPickerView()
            
            VStack(spacing: 8) {
                InputView(text: $viewModel.username, title: "Username", placeholder: "Username")
                
                InputView(text: $viewModel.phone, title: "Phone Number", placeholder: "+44 *********")
                
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
                viewModel.handleAction()
            } label: {
                Text("Create Account")
                    .font(.headline)
                    .foregroundStyle(formIsValid ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(formIsValid ? .black : .gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .disabled(formIsValid)
            }
        }
    }
}
extension RegistrationView: AuthFormProtocol {
    var formIsValid: Bool {
        return !viewModel.phone.isEmpty
        && viewModel.phone.count == 11
        && !viewModel.username.isEmpty
        && viewModel.username.count > 3
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
        && viewModel.confirmPassword == viewModel.password
    }
}
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(LoginViewModel())
    }
}

struct PhotoPickerView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    var body: some View {
        PhotosPicker(selection: $viewModel.imageSelection) {
            VStack {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                } else {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.black)
                        Text("Upload photo")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}
