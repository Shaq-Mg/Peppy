//
//  PeppyApp.swift
//  Peppy
//
//  Created by Shaquille McGregor on 26/04/2024.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct PeppyApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let viewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
        }
    }
}
