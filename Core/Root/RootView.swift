//
//  RootView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 27/10/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    var body: some View {
        Group {
            if authVM.userSession != nil {
                SettingsView()
            } else {
                SignInView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
            .environmentObject(AuthenticationViewModel())
    }
}
