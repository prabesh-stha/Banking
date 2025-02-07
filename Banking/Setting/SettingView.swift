//
//  SettingView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 07/02/2025.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel: SettingViewModel
    @Binding var isLoggedIn: Bool
    
    init(isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: SettingViewModel(auth: AuthenticationManager()))
        _isLoggedIn = isLoggedIn
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

        }
    }
}

#Preview {
    SettingView(isLoggedIn: .constant(false))
}
