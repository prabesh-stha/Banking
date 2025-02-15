//
//  ContentView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
//

import SwiftUI

struct RootView: View {
    @Binding var isLoggedIn: Bool
    init(isLoggedIn: Binding<Bool>) {
        _isLoggedIn = isLoggedIn
    }
    var body: some View {
        NavigationStack{
            TabView {
                Tab("Home", systemImage: "house") {
                    HomeView()
                }
                Tab("Setting", systemImage: "gear") {
                    SettingView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}

#Preview {
    RootView(isLoggedIn: .constant(false))
}
