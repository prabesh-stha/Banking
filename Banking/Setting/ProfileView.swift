//
//  ProfileView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 14/02/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: UserManager(), auth: AuthenticationManager()))
    }
    var body: some View {
        VStack{
            if let user = viewModel.userAccount {
                Text(user.firstName)
            }
        }
        .onAppear {
            Task{
                try await viewModel.getUser()
            }
        }
    }
}

#Preview {
    ProfileView()
}
