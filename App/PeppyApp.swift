//
//  PeppyApp.swift
//  Peppy
//
//  Created by Shaquille McGregor on 11/08/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct PeppyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var locationVM = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MapView()
                    .environmentObject(authViewModel)
                    .environmentObject(locationVM)
            }
        }
    }
}
