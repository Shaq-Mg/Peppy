//
//  SettingsView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    var body: some View {
        List {
            Section {
                profileHeader
            }
            
            Section("General") {
                HStack {
                    SettingsCellView(imageName: "gear", title: "Version")
                    Spacer()
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemGray))
                }
            }
            
            Section("Account") {
                Button {
                    
                } label: {
                    SettingsCellView(imageName: "lock.fill", title: "Sign Out")
                }
                
                Button {
                    authVM.signOut()
                } label: {
                    SettingsCellView(imageName: "minus.circle.fill", title: "Delete Account")
                }
            }
            .navigationDocument("Settings")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AuthenticationViewModel())
    }
}

extension SettingsView {
    private var profileHeader: some View {
        HStack {
            Text(authVM.currentUser?.firstLetter ?? "U")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 65, height: 65)
                .background(Color(.systemGray3))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(authVM.currentUser?.name ?? "User")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 4)
                
                Text(authVM.currentUser?.email ?? "user@gmail.com")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .tint(.gray)
            }
        }
    }
}
