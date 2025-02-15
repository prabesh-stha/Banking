//
//  LogInView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel
    @State private var showPassword: Bool = false
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    var body: some View {
        VStack{
            
            Image("home")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            
            VStack{
                CustomTextField(text: $authViewModel.email, title: "Email", show: .constant(true), focusState: $isEmailFocused, imageName: "envelope")
                    .onChange(of: isEmailFocused, initial: false) {
                        withAnimation(.easeInOut(duration: 0.3)){}
                    }
                    .padding(.bottom, 7.5)
                CustomTextField(text: $authViewModel.password, title: "Password", show: $showPassword, focusState: $isPasswordFocused, imageName: "lock")
                    .onChange(of: isEmailFocused, initial: false) {
                        withAnimation(.easeInOut(duration: 0.3)){}
                    }
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            showPassword.toggle()
                                   }) {
                                       Image(systemName: showPassword ? "eye.slash" : "eye")
                                           .foregroundColor(.gray)
                                   }
                                   .background(Color.white)
                                   .padding(.trailing, 25)
                    }
                    .padding(.bottom,7.5)
                
                
                Button {
                    Task{
                        do{
                            try await authViewModel.signIn()
                            authViewModel.saveCredentials()
                            
                        }catch{
                            authViewModel.showAlert = true
                            authViewModel.alertMessage = "Sorry couldn't logged in to your account at the moment. 😔"
                        }
                    }
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Spacer()
                

        }
        .navigationTitle("Welcome")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SignInView(authViewModel: AuthenticationViewModel(auth: AuthenticationManager()))
    }
}
