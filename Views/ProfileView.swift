//
//  ProfileView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 02/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        if FirebaseManager.shared.auth.currentUser?.uid == nil {
            List {
                ProfileHeader()
                
                AccountInfoSection()
                Button {
                    vm.isLoginMode.toggle()
                } label: {
                    Text("Sign Out")
                        .font(.headline)
                }
                Button {
                    
                } label: {
                    Text("Delete Acount")
                        .font(.headline)
                }
            }
            .navigationTitle("My Account")
            .navigationBarItems(trailing: Button(action: {
                vm.isUserCurrentlyLoggedOut.toggle()
            }, label: {
                Text("Sign out").bold()
            }))
            .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut) {
                RootView()
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(LoginViewModel())
    }
}

struct ProfileHeader: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        if let user = vm.chatUser {
            HStack(spacing: 14){
                Text("Photo")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 70, height: 70)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(user.username)
                        .font(.headline)
                    
                    Text("@\(user.username)")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            
        }
    }
}

struct AccountInfoSection: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        Section(header: Text("Account Info")) {
            TextField("Username", text: $vm.username)
            TextField("phone", text: $vm.phone)
            Button {
                
            } label: {
                Text("Update info")
            }
        }
    }
}
