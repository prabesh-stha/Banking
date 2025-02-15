//
//  SignUpView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 06/02/2025.
//

import SwiftUI

struct SignUpView: View {
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
                            try await authViewModel.signUp()
                    }
                } label: {
                    Text("Sign up")
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
    SignUpView(authViewModel: AuthenticationViewModel(auth: AuthenticationManager()))
}
