//
//  MainTabView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        VStack {
            TabView {
                MainMessagesView()
                    .tabItem {
                        Image(systemName: "paperplane")
                        Text("Messages")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Account")
                    }
            }
            .tint(.mint)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainTabView()
        }
    }
}
