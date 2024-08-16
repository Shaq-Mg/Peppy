//
//  RootView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MapView()
            } else {
                LoginView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RootView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
