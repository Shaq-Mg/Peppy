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
        List {
            ProfileHeader()
            
            AccountInfoSection()
            Button {
                vm.showSignOutAlert.toggle()
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
        .actionSheet(isPresented: $vm.showSignOutAlert, content: {
            .init(title: Text("Sign Out").bold(), message: Text("Are you sure that you want to sign out your account?"), buttons: [
                .destructive(Text("Yes").bold(), action: {
                    vm.signOut()
                    vm.loginStatusMessage = ""
                }),
                .cancel()
            ])
        })
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            RootView(didCompleteLoginProcess: {
                vm.isUserCurrentlyLoggedOut = false
                vm.fetchCurrentUser()
            })
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
            TextField("email", text: $vm.email)
            Button {
                
            } label: {
                Text("Update info")
            }
        }
    }
}
