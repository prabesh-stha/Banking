//
//  AuthenticationView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel: AuthenticationViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: AuthenticationViewModel(auth: AuthenticationManager()))
    }
    
    var body: some View {
        
        if viewModel.isLoggedIn{
            RootView(isLoggedIn: $viewModel.isLoggedIn)
        }else if !viewModel.isLoading && viewModel.signup{
            VStack{
                Button("Switch"){
                    viewModel.signup.toggle()
                }
                SignUpView(authViewModel: viewModel)
                    .alert("", isPresented: $viewModel.showAlert) {
                        Button("OK"){}
                    } message: {
                        Text(viewModel.alertMessage)
                    }
//                NewUserView()
                Button("Login with Face ID") {
                                Task {
                                    try await viewModel.loginWithFaceID()
                                }
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
            }
        }else{
            VStack{
                Button("Switch"){
                    viewModel.signup.toggle()
                }
                SignInView(authViewModel: viewModel)
                    .alert("", isPresented: $viewModel.showAlert) {
                        Button("OK"){}
                    } message: {
                        Text(viewModel.alertMessage)
                    }
                Button("Login with Face ID") {
                                Task {
                                    try await viewModel.loginWithFaceID()
                                }
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
