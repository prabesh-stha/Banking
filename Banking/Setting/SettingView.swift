//
//  SettingView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 07/02/2025.
//

import SwiftUI

struct SettingView: View {
    let userId: String
    @StateObject private var viewModel: SettingViewModel
    @Binding var isLoggedIn: Bool
    
    init(userId: String, isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: SettingViewModel(auth: AuthenticationManager(), account: AccountManager()))
        _isLoggedIn = isLoggedIn
        self.userId = userId
    }
    var body: some View {
        List {
            Button {
                Task{
                    do{
                        try viewModel.signOut()
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign out")
            }
            .alert("Message", isPresented: $viewModel.showAlert) {
                Button("OK"){
                    isLoggedIn = viewModel.isSuccessful ? false : true
                }
            } message: {
                Text(viewModel.alertMessage)
            }
            NavigationLink {
                ProfileView()
            } label: {
                Text("Profile")
            }

            
            if let userAccount = viewModel.userAccount {
                NavigationLink {
                    ChangePinView(accountNo: userAccount.accountNo)
                } label: {
                    Text("Change Pin")
                        .foregroundStyle(Color.blue)
                }

            }

        }
        .onAppear {
            Task{
                try await viewModel.getAccount(userId: userId)
            }
        }
    }
}

#Preview {
    SettingView(userId: "", isLoggedIn: .constant(false))
}
