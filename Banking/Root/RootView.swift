//
//  ContentView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel: RootViewModel
    @Binding var isLoggedIn: Bool
    init(isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: RootViewModel(user: AuthenticationManager()))
        _isLoggedIn = isLoggedIn
    }
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack{
            TabView {
                Tab("Home", systemImage: "house") {
                    HomeView(userId: viewModel.userId)
                }
                Tab("Setting", systemImage: "gear") {
                    SettingView(userId: viewModel.userId, isLoggedIn: $isLoggedIn)
                }
            }
        }
        .onAppear{
            viewModel.getUser()
        }
        .alert("Message", isPresented: $viewModel.showMessage) {
            Button("OK"){
                dismiss()
            }
        } message: {
            if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    RootView(isLoggedIn: .constant(false))
}
