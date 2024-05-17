//
//  HomeView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        VStack {
            NavigationStack {
                MainTabView()
            }
        }
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            RootView(didCompleteLoginProcess: {
                vm.isUserCurrentlyLoggedOut = false
                vm.fetchCurrentUser()
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environmentObject(LoginViewModel())
        }
    }
}
