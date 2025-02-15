//
//  BankingApp.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
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
struct BankingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            SignInView(authViewModel: AuthenticationViewModel(auth: AuthenticationManager()))
            AuthenticationView()
//            DummyView()
        }
    }
}
